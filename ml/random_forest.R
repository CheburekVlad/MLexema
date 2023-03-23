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
  # print(VoIcol)

  VoI = unlist(unname(as.vector(unique(VoIcol))))
  # print(VoI)

  dataset$transformedVoi = sapply(VoIcol, function(x) ifelse(x == VoI[1], 1, 0))

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

#creation_dataset("eczema_data.xlsx", "Diagnosis", 0.7)

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
  #' @return 'lmProfile'
  #' @export

  # Permet de sélectionner les meilleures variables à inclure dans un modèle statistique

  ctrl <- rfeControl(functions = rfFuncs,
                     method = "repeatedcv",
                     repeats = k,
                     verbose = FALSE)

  # La fonction rfe évalue les variables en les ajoutant et en les supprimant du modèle à
  # plusieurs reprises jusqu'à ce qu'une sélection optimale soit trouvée.

  lmProfile <<- rfe(x=trainData[,c(2:j)], y=VoI,
                   sizes = b,
                   rfeControl = ctrl)

  rfeList <<- as.list(lmProfile$optVariables)

  varRfe <<- unlist(unname(rfeList))
  print(varRfe)
  formulRfe <<- paste(varRfe, collapse = "*")

  print(formulRfe)

  return(formulRfe)
  # Récupère les noms des variables de lmprofile et l'insérer lors de la création du modèle ?
}

# print(RfeMethod(5,13,5,trainData$transformed_VoI))

trainModelSVM = function(){
  # fonction a revoir
  # La fonction "tuneGrid" est utilisée pour spécifier une grille de paramètres pour la recherche des meilleurs paramètres de modèle.
  # Vous pouvez ajuster les valeurs de cette grille pour trouver les meilleurs paramètres pour votre propre ensemble de données.
  svmModel <- train(x = train[, -1], y = train[, 1], method = "svmRadial", trControl = ctrl,
                     tuneLength = 10, metric = "Accuracy",
                     preProcess = c("center", "scale"),
                     tuneGrid = data.frame(C = 10^seq(-2, 2, by = 0.5),
                                           gamma = 10^seq(-2, 2, by = 0.5)))
}



trainModel = function(responseVar, methode){
  #'
  #' Cette fonction prend en entrée la methode de création du modèle et entraine le modèle selon cette
  #' méthode. En sortie on a le modèle entrainé.
  #'
  #' @param methode chaine de caractères
  #' @return modèle entrainé
  #' @export

  ctrl <- trainControl(method = "cv", number=5)

  formula <- as.formula(paste(responseVar,"~",formulRfe))
  print(formula)

  newModel <<- train(formula, data=trainData, method=methode, trControl=ctrl)
  #fitted = predict(model, trainData)
  print("ok")
}
