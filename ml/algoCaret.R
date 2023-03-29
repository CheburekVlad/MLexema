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
  
  VoI = unlist(unname(as.vector(unique(VoIcol))))
 
  dataset$transformedVoi = sapply(VoIcol, function(x) ifelse(x == VoI[1], 1, 0))
                                  
    # Création du jeu d'entrainement et du jeu de test
  trainRowNumber <- createDataPartition(y = dataset$transformedVoi, p = partition, list = FALSE)
  trainData <<- dataset[trainRowNumber,]
  testData <<- dataset[-trainRowNumber,]

}

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

  print("Entraînement terminé")
  return(newModel)
}


