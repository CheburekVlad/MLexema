# Pré-charge les fonctions d'analyse random forest
source(file.path('ml', 'random_forest.R'))
listeModeles = as.list(list.files("trainedModel"))

verif=function(){

  #' Cette fonction ne prends pas d'entrée et ne renvoie aucune valeur.
  #' Elle vérifie si le nom des packages contenue dans la liste my_packages
  #' sont contenus dans la liste des packages installés. Dans le cas contraire le nom
  #' du packages est inséré dans la variable to_install qui est transmise à la
  #' commande "install.packages()" qui vectorise sur la variable to_install

  ### VERIFICATION DE LA PRESENCE DES PACKAGES ET INSTALLES CEUX QUI NE SONT PAS RPESENT ###
  my_packages = c("caret", "skimr", "RANN" , "randomForest",
                  "gbm", "xgboost" , "caretEnsemble" ,
                  "C50" , "earth", "openxlsx", "skimr", "ROCR",
                  "shinydashboard", "shiny")

  install_package = installed.packages()[,1]
  to_install = my_packages[!my_packages %in% install_package]
  if (length(to_install)>0){install.packages(to_install)}
  #### CHARGEMENT DES PACKAGES ######
  library(openxlsx)
  library(caret)
  library(skimr)
  library(ROCR)
  library(shinydashboard)
  library(shiny)
  library(readxl)
  library(dplyr)
}

verif()
