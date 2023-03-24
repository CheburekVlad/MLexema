{ algoLayout = fluidRow(
  #strong("1) Estimation des meilleures variables pour la construction du modèle"),
  #br(),br(), br(),
  #numericInput("repetitionK", "Nombre de répétition pour l'analyse des variables importantes", value = 5, min = 0, max = 10),
  #numericInput("columnJ", "Numéro de la dernière colonne prise en compte", value = 13 , min = 1, max = 100),
  #numericInput("Voib", "Nombre de variables importantes minimum que l'on souhaite en sortie", value = 3, min = 0, max = 10),

  #actionButton("verification", "Analyse"),
  #verbatimTextOutput("print"),
  #br(),
  #strong("Variables d'intérêt identifiées : "),
  #textOutput("mlVoiResult"),
  #verbatimTextOutput("verb"),
 # br(), br(),

  strong("1) Entrainement des modèles"),
  
  selectInput("typeOfMl", h3("Choix du type de modèle"),
              c("Random forest" = "rf",
                "Support vector machine" = "svm",
                "K-means" = "kmeans",
                "Neural Network" = "neuralnet"
                )),

   actionButton("train", "Entraînement"),
   actionButton("metric","Analyse des modèles"),
  )
}
