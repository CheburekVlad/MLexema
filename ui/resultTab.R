{ resultsLayout = fluidRow(
  textOutput("mlResult"),

  strong("1) Mesure de la pertinence du modèle"),
  plotOutput("mlPlot"),
  # plotOutput("ml2Plot"),
  # br(),br(),

  strong("2) Prédiction sur le jeu de données de test"),
  br(),br(),
  strong("Prédiction"),
  br(),br(),
  tableOutput("predictTable"),

  strong("Matrice de confusion"),
  uiOutput("confMatrix"),
  verbatimTextOutput("verb"),

  strong("Courbe ROC"),
  plotOutput('RocCurve'),

  textInput("name","Nom du fichier"),
  actionButton("save","Sauvegarde du modèle")

)}
