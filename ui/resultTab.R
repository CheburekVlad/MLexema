resultsLayout = fluidRow(
  textOutput("mlResult"),
  
  div(id = "mlPlotDiv", 

    strong("Mesure de la pertinence du modèle"),
    plotOutput("mlPlot"),
    # plotOutput("ml2Plot"),
    br(),br()
  ),

  strong("Prédiction du modele"),
  br(),br(),
  strong("Prédiction"),
  br(),br(),
  tableOutput("predictTable"),
  
  strong("Matrice de confusion/Precision de clusturing"),
  uiOutput("confMatrix"),
  verbatimTextOutput("verb"),
  
  strong("Courbe ROC"),
  plotOutput('RocCurve'),
  
  textInput("name","Nom du fichier"),
  actionButton("save","Sauvegarde du modèle")
  
)