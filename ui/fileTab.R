fileLayout = fluidRow(
  
  # Choix du modèle pré-entrainé
  selectInput("trainedModel", "Choisir un modèle pré-entrainé:", choices = listModels),
  actionButton("load", "Chargement modèle"),

  # Choix du type de données
  radioButtons("radio", label = "Format de fichier:", choices = list("Données brutes" = 1, "Données fold change" = 2), selected = 1),
  numericInput("numPartition", "Pourcentage de partition", value = 0.75, min = 0, step = 0.05, max = 1),

  br(),br(),
  
  # Chargement du fichier
  fileInput("FileInputButton", label = "Fichier d'entrée", accept = c(".xlsx")),

  actionButton("submit", "Soumettre"),

  uiOutput("previewPanel"),

  br(),br(),br()
)