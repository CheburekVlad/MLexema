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

  strong("1) Choix du modele"),
  
  br(),
  
  tabsetPanel(
    #Random forest
    tabPanel("Random Forest", value = "rf",hidden = T,
             conditionalPanel(condition = "input.type =='rf'",
                  fluidRow(
                    actionButton("train", "Entraînement"),
                    actionButton("metric","Analyse des modèles")
                  ))),
    
    #SVM
    tabPanel("SVM", value = "svm", hidden = T),
    
    #Kmeans
    tabPanel("Kmeans", value = "km",hidden = T),
    
    #NeuralNet
    tabPanel("Reseau de neurones", value = "nn", hidden = T)
  )

  )
}
