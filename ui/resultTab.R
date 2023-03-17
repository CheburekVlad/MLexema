
{ resultsLayout = fluidRow(
  textOutput("ml_result"),

  strong("1) Mesure de la pertinance du modèle"),
  plotOutput("ml_plot"),
  plotOutput("ml2_plot"),
  br(),br(),

  strong("2) Prédiction sur le jeu de donné de test"),
  br(),br(),
  actionButton("predict","Prédiction"),
  br(),br(),
  uiOutput("predict"),

  actionButton("confMatrice","Matrice de confusion"),
  uiOutput("confMatrice"),

  actionButton("ROC","courbe ROC"),
  plotOutput('RocCurve')

)}
