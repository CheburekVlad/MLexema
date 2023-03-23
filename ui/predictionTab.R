
{ predictionLayout = fluidRow(

  fileInput("fileInputPred", label = "Fichier d'entrée",accept = c(".xlsx")),

  uiOutput("previewPanelPrediction"),

  actionButton('prediction', "Prédiction"),

  uiOutput("prediction1"),

)}
