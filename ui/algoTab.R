{ algoLayout = fluidRow(
  strong("1) Estimation des meilleures variables pour la construction du modèle"),
  br(),br(), br(),
  numericInput("repetitionK", "Nombre de répétition pour l'analyse des variables importantes", value = 5, min = 0, max = 10),
  numericInput("columnJ", "Numéro de la dernière colonne prise en compte", value = 13 , min = 1, max = 100),
  numericInput("Voib", "Nombre de variables importantes minimum que l'on souhaite en sortie", value = 3, min = 0, max = 10),

  actionButton("verification", "Analyse"),
  br(),br(),br(),
  strong("Variables d'intérêt identifiées : "),
  textOutput("mlVoiResult"),
  br(), br(), br(),
  
  strong("2) Entrainement des modèles"),

  textInput("typeOfMl", label = h3("Text input"), value = "rf"),

  column(1,actionButton("train", "Entraînement")),
  column(4,actionButton("metric","Analyse des modèles")),
  )
}
