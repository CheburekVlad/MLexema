creation_dataset = function(file_name, VoIname ,partition){
  #'
  #' Cette fonction prend en entrée une nom de fichier, la variable d'intéret, le ratio de partition des données
  #'  et renvoie un dataset, un jeux d'entraînement et un jeu de test qui vont servir à la réalisation
  #'  d'un modèle de machine learning.
  #'
  #' @param file_name une chaine de caractère
  #' @param VoIname nom de variable de data_frame
  #' @param partition un float comprit entre 0 et 1
  #'
  #' @return un dataset un jeux d'entrainement et un jeu de test
  #'
  #' @export
  #Chargement du jeu de données
  #set.seed(100)
  dataset <<- read.xlsx(file_name)

  VoIcol = dataset[VoIname]
  #print(VoIcol)
  VoI = unlist(unname(as.vector(unique(VoIcol))))
  #print(VoI)
  dataset$transformed_VoI = sapply(VoIcol, function(x) ifelse(x == VoI[1], 1, 0))

    #Creation du jeux d'entrainement et du jeu de test
  trainRowNumber <- createDataPartition(y = dataset$transformed_VoI, p=partition, list=FALSE)
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

RFE_method=function(k,j,b,VoI){
  #'
  #' Cette fonction prend en entrée k : le nombre de répétition de la fonction rfeControl, j le numéro
  #' des colonnes pris en compte dans le dataset et b le maximum de variable que
  #' l'on estime nécessaire pour notre modèle. Et donne en sortie les variables les plus importantes
  #' pour la création d'un modèle.
  #'
  #' @param k un entier
  #' @param j un entier
  #' @param b un entier
  #' @param VoI la variable d'intérêt du jeu de données (in==tégrer la  transformation automatique en factdeur
  #'  si c'est une chaine de caractère : as.factor)
  #'
  #' @return 'lmProfile'
  #' @export

  #Permet de sélectionner les meilleures variables à inclure dans un modèle statistique

  ctrl <- rfeControl(functions = rfFuncs,
                     method = "repeatedcv",
                     repeats = k,
                     verbose = FALSE)

  #La fonction RFE évalue les variables en les ajoutant et en les supprimant du modèle à
  #plusieurs reprises jusqu'à ce qu'une sélection optimale soit trouvée.

  lmProfile <<- rfe(x=trainData[,c(2:j)], y=VoI,
                   sizes = c(1:b),
                   rfeControl = ctrl)

  rfeList <<- as.list(lmProfile$optVariables)

  varRfe <<- unlist(unname(rfeList))
  print(varRfe)
  formulRfe <<- paste(varRfe, collapse = "*")

  print(formulRfe)
  
  return(formulRfe)
  #recuper les noms des variables de lmprofile et l'insérer lors de la création du model ?
}
#print(RFE_method(5,13,5,trainData$transformed_VoI))

trainModelSVM = function(){
  #fonction a revoir
  #tuneGrid permet  La fonction "tuneGrid" est utilisée pour spécifier une grille de paramètres pour la recherche des meilleurs paramètres de modèle.
  #Vous pouvez ajuster les valeurs de cette grille pour trouver les meilleurs paramètres pour votre propre ensemble de données.
  svm_model <- train(x = train[, -1], y = train[, 1], method = "svmRadial", trControl = ctrl,
                     tuneLength = 10, metric = "Accuracy",
                     preProcess = c("center", "scale"),
                     tuneGrid = data.frame(C = 10^seq(-2, 2, by = 0.5),
                                           gamma = 10^seq(-2, 2, by = 0.5)))
}



trainModelRF = function(response_var,var_imp,methode){
  #'
  #' Cette fonction prend en entrée la methode de création du modèle et entraine le modèle selon cette
  #' méthode. En sortie on a le modèle entrainer.
  #'
  #' @param methode chaine de caractère
  #' @return modèle entrainé
  #' @export

  ctrl <- trainControl(method = "cv", number=5)

  formula <- as.formula(paste(response_var,"~",formulRfe))
  print(formula)

  model_rf <<- train(formula, data=trainData, method=methode, trControl=ctrl)
  #fitted = predict(model_rf, trainData)
  print("ok")
}
#trainModelRF( c("GPR183","PLEK","IGFL3"),"rf" )


Metric = function(model){
  #'
  #' Cette fonction prends en entré un model de machine learning et
  #' fournit un graph sur la précision du model ainsi que les variables
  #' importante pour la construction du modèle
  #'
  #' @param model modèle de machine learning
  #' @return varimp-rf
  #' @export
  plot(model_rf, main="Model Accuracies with randomforest")

  varimp_rf <<- varImp(model_rf)

  plot(varimp_rf, main="Variable Importance with rf")

  varimp_rf
}
#Metric(model_rf)


predicted_result=function(model,data){
  #'
  #' Cette fonction prends en entré un model de machine learning et les données à analyser et sort
  #' les prédictions effectué par le model.
  #' @param model modèle de machine learning
  #' @param data jeux de donné à tester
  #' @return predicted
  #' @export
  #'
predicted <<- predict(model_rf, testData)

}

Matrixconf=function(ref,datas){
confusionMatrix(reference = ref, data = datas)}

Roc_curve = function(predicted, VarImp){
  #'
  #' Cette fonction prends en entré un model de machine learning et la variable d'intérêt
  #' et donne une courbe ROC
  #' @param predicted prédiction du modèle de machine learning
  #' @param VarImp Variable d'intérêt
  #' @return ROC curve
  #' @export

pred2 = prediction(predicted, testData$transformed_VoI)
plot(performance(pred2,"tpr", "fpr"))

}
