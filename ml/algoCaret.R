creationDataset = function(fileName, VoIname, partition){
  #'
  #' Cette fonction prend en entrée un nom de fichier, la variable d'intérêt, le ratio de partition des données
  #'  et renvoie un dataset, un jeu d'entraînement et un jeu de test qui vont servir à la réalisation
  #'  d'un modèle de machine learning.
  #'
  #' @param fileName une chaine de caractère
  #' @param VoIname nom de variable de dataframe
  #' @param partition un float compris entre 0 et 1
  #'
  #' @return un dataset un jeu d'entrainement et un jeu de test
  #'
  #' @export
  # Chargement du jeu de données
  # set.seed(100)
  dataset <<- read.xlsx(fileName)

  VoIcol = dataset[VoIname]
  colnames(VoIcol) = "transformedVoi"
  # print(VoIcol)

  VoI = unlist(unname(as.vector(unique(VoIcol))))
  # print(VoI)

  dataset$transformedVoi = sapply(VoIcol, function(x) ifelse(x == VoI[1], 1, 0))
  # print(head(dataset))
    # Création du jeu d'entrainement et du jeu de test
  trainRowNumber <- createDataPartition(y = dataset$transformedVoi, p = partition, list = FALSE)
  trainData <<- dataset[trainRowNumber,]
  testData <<- dataset[-trainRowNumber,]

  #preProcValues <- preProcess(trainData[,2:13], method = c("center", "scale"))
  #preProcValues
  #train

  #train[,2:13] <- predict(preProcValues, train[,2:13])
  #test[,2:13] <- predict(preProcValues, test[,2:13])
  #train

  #x <<- trainData[, 2:13]
  #y <<- trainData$Diagnosis
}

#creationDataset("../dataset_RF_sans_barx2.xlsx", "Diagnosis", 0.7)

RfeMethod=function(k,j,b,VoI){
  #'
  #' Cette fonction prend en entrée k : le nombre de répetition de la fonction rfeControl, j le numéro
  #' des colonnes pris en compte dans le dataset et b le maximum de variable que
  #' l'on estime nécessaire pour notre modèle. Et donne en sortie les variables les plus importantes
  #' pour la création d'un modèle.
  #'
  #' @param k un entier
  #' @param j un entier
  #' @param b un entier
  #' @param VoI la variable d'intérêt du jeu de données (intégrer la transformation automatique en facteur
  #'  si c'est une chaine de caractère : as.factor())
  #'
  #' @return 'formulRfe'
  #' @export

  # Permet de sélectionner les meilleures variables à inclure dans un modèle statistique

  ctrl <- rfeControl(functions = rfFuncs,
                     method = "repeatedcv",
                     repeats = k,
                     verbose = FALSE)

  # La fonction rfe évalue les variables en les ajoutant et en les supprimant du modèle à
  # plusieurs reprises jusqu'à ce qu'une sélection optimale soit trouvée.
  # RFE = recursive feature elimination

  lmProfile <<- rfe(x=trainData[,c(2:j)], y=VoI,
                   sizes = b,
                   rfeControl = ctrl)

  rfeList <<- as.list(lmProfile$optVariables)

  varRfe <<- unlist(unname(rfeList))

  formulRfe <<- paste(varRfe, collapse = "*")

  print(formulRfe)

  return(formulRfe)
  # Récupère les noms des variables de lmprofile et l'insérer lors de la création du modèle ?
}

#print(RfeMethod(5,13,5,trainData$transformedVoi))





# trainModelSVM = function(responseVar, method){
#   set.seed(123)
#   # Le paramètre tuneLength indique à l'algorithme d'essayer différentes valeurs par défaut pour le paramètre principal
#   # Ici, on utilise 10 valeurs par défaut
#   # La précision (metric = "Accuracy") a été utilisée pour sélectionner le modèle optimal en utilisant la plus grande valeur retournée parmi les 10 valeurs.
#   svmModel <- train(formula, data=trainData, method=methode, trControl=trainControl(method = "cv"),
#                      tuneLength = 10, metric = "Accuracy",
#                      tuneGrid = data.frame(C = 10^seq(-2, 2, by = 0.5),
#                                            gamma = 10^seq(-2, 2, by = 0.5)))
# }


# set.seed(123)
# Le paramètre tuneLength indique à l'algorithme d'essayer différentes valeurs par défaut pour le paramètre principal
# Ici, on utilise 10 valeurs par défaut
# La précision (metric = "Accuracy") a été utilisée pour sélectionner le modèle optimal en utilisant la plus grande valeur retournée parmi les 10 valeurs.
# Le paramètre tuneGrid nous permet de décider quelles valeurs prendra pour le paramètre principal
# Alors que tuneLength ne limite que le nombre de paramètres par défaut à utiliser.

# Accuracy est le pourcentage d'instances correctement classées parmi toutes les instances.
# Il est plus utile sur une classification binaire que sur les problèmes de classification multi-classes,
# car il peut être moins clair de comprendre comment la précision se répartit entre ces classes
# (par exemple, vous devez approfondir avec une matrice de confusion).
#
# Le Kappa est comme la classification avec Accuracy,
# sauf qu'il est normalisé à la base du hasard aléatoire sur votre ensemble de données.
# C'est une mesure plus utile à utiliser sur les problèmes qui présentent un déséquilibre dans les classes
# (par exemple, une répartition 70-30 pour les classes 0 et 1 et vous pouvez obtenir une précision de 70 % en prédisant que toutes les instances sont pour la classe 0).
#
# trainData$Diagnosis = make.names(c("ACD", "ACD", "no ACD", "no.ACD"), unique = FALSE)
# train(Diagnosis~GPR183*IGFL3, data=trainData, method="svmRadial", trControl=trainControl(method = "cv", classProbs = TRUE, summaryFunction=twoClassSummary),
#                   tuneLength = 15, metric = "ROC")
#
# train(Diagnosis~GPR183*IGFL3, data=trainData, method="nnet", trControl=trainControl(method = "cv"),tuneGrid=expand.grid(size=c(10), decay=c(0.1)))
# #




trainModel = function(responseVar, methode,genes){
  #'
  #' Cette fonction prend en entrée la methode de création du modèle et entraine le modèle selon cette
  #' méthode. En sortie on a le modèle entrainé.
  #'
  #' @param methode chaine de caractères
  #' @return modèle entrainé
  #' @export

  ctrl <- trainControl(method = "cv", number=10)

  formula <- as.formula(paste(responseVar,"~", paste(genes, collapse = "*")))

  print(formula)
  if(methode == 'rf') {
    newModel <<- train(formula, data=trainData, method='rf', trControl=ctrl)
    print(newModel)
  } else if(methode == 'svm') {
    newModel <<- train(formula, data=trainData, method='svmRadial', trControl=ctrl, tuneLength = 10, metric = "Accuracy")
    print(newModel)
  }
  else if(methode == 'neuralnet') {
    newModel <<- train(formula, data=trainData, method='nnet', trControl=ctrl#, tuneGrid=expand.grid(size=c(10), decay=c(0.1))
    )
  }


  #fitted = predict(model, trainData)
  print("ok")
  return(newModel)
}

#m = trainModel("Diagnosis", "svm")

