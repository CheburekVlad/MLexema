
{ fileLayout = fluidRow(
  #choix du type de données
  radioButtons("radio",label = "Format de fichier:",choices = list("Données brutes" = 1, "Données fold change" = 2), selected = 1),
  numericInput("num_partition", "Pourcentage de partition", value = 0.75, min = 0, max = 1),
  
  br(),br(),
  #chargement du fichier
  fileInput("fileInput", label = "Fichier d'entrée",accept = c(".xlsx")),
  
  actionButton("submit", "Soumettre"),
  
  uiOutput("previewPanel"),
  
  br(),br(),br()
)}
