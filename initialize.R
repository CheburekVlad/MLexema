# Pré-charge les fonctions d'analyse random forest
source(file.path('ml', 'random_forest.R'))
source(file.path('ml','Kmeans.R'))
listModels = as.list(list.files("trainedModel"))

verif=function(){

  #' Cette fonction ne prend pas d'entrée et ne renvoie aucune valeur.
  #' Elle vérifie si le nom des packages contenu dans la liste my_packages
  #' sont dans la liste des packages installés. Dans le cas contraire le nom
  #' du package est inséré dans la variable toInstall qui est transmise à la
  #' commande "install.packages()" qui vectorise sur la variable toInstall

  ### VERIFICATION DE LA PRESENCE DES PACKAGES ET INSTALLE CEUX QUI NE SONT PAS PRESENT ###
  myPackages = c("caret", "skimr", "RANN" , "randomForest",
                  "gbm", "xgboost" , "caretEnsemble" ,
                  "C50" , "earth", "openxlsx", "skimr", "ROCR",
                  "shinydashboard", "shiny","neuralnet","amap")

  installPackage = installed.packages()[,1]
  toInstall = myPackages[!myPackages %in% installPackage]
  if (length(toInstall)>0){install.packages(toInstall)}
  
  #### CHARGEMENT DES PACKAGES ######
  library(openxlsx)
  library(caret)
  library(skimr)
  library(ROCR)
  library(shinydashboard)
  library(shiny)
  library(readxl)
  library(dplyr)
  library(neuralnet)
  library(amap)
}

verif()
