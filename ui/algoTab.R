{ algoLayout = fluidRow(
  
  strong("1) Choix du modele"),
  
  br(),
  br(),
  
  tabsetPanel(
    #Random forest
    tabPanel("Random Forest", value = "rf",hidden = T,style = "margin-left: 20px",
        fluidRow(
          br(),
          br(),
          actionButton("trainrf", "Entraînement",style = "margin-left: 20px"),
          actionButton("metricrf","Analyse du modèle")
        )
    ),

    #SVM
    tabPanel("SVM", value = "svm", hidden = T,
        fluidRow(
          br(),
          br(),
          actionButton("trainsvm", "Entraînement",style = "margin-left: 20px"),
          actionButton("metricsvm","Analyse du modèle")
        )
    ),
    
    #Kmeans
    tabPanel("Kmeans", value = "km",hidden = T,
        fluidRow(
          br(),
          numericInput("clusters",".      Nombre de clusters:",value = 2,min = 2,step = 1),
          numericInput("nstart",".      Nombre d'essais aleatoires:",value = 5, min =3, max = 10,step = 1),
          numericInput("iter",".      Nombre d'iterations max:",value = 15, min = 5, step = 5),
          actionButton("kmeans", "Clustering")
        ),
    ),

    # Au cas ou neuralnet sera implementé voici le template d'integration
    # #NeuralNet
    # tabPanel("Reseau de neurones", value = "nn", hidden = T,
    #   conditionalPanel(condition = "input$type =='nn'",
    #     fluidRow(actionButton("nn.result","Result"))
    #   )
    # )
  )
  
)}
