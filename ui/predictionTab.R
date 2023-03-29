
{ predictionLayout = fluidRow(
  
  #Chargement du fichier pour l'analyse par le model existant
  fileInput("fileInputPred", label = "Fichier d'entrée",accept = c(".xlsx")),

  uiOutput("previewPanelPrediction"),

  actionButton('prediction', "Prédiction"),

  uiOutput("prediction1"),

)}
