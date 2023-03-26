algoBackend = function (input, output, session) {

  #observeEvent(
  #  eventExpr = input$verification,
  #  handlerExpr = {
  #    withProgress(
  #        message = "Recherche des varables d'intérêt", value = 1, {
  #        mlVoiResult = RfeMethod(input$repetitionK, input$columnJ, input$Voib,trainData$transformedVoi)
  #        output$mlVoiResult = renderText(mlVoiResult)
  #        output$print = renderPrint(lmProfile, width=1000)
  
  
  observeEvent(
    eventExpr = input$type,
    handlerExpr = {
      updateTabsetPanel(session, "tabs",
                        selected = "rf",
                        tabPanel("Choix du modele",
                                 selectInput("type","Veuillez choisir un modele:",
                                             choices = c("Random Forest","SVM","Kmeans","NeuralNet"))))
    })
  
  observeEvent(
    eventExpr = input$type,
    handlerExpr = {
    selected_option <- input$type

    # Show corresponding tab
    if (selected_option == "Random Forest") {
      updateTabsetPanel(session, "tabs", selected = "rf")
      
      } 
    else if (selected_option == "SVM") {updateTabsetPanel(session, "tabs", selected = "svm")} 
    else if (selected_option == "Kmeans") {updateTabsetPanel(session, "tabs", selected = "km")}
    else if (selected_option == "NeuralNet") {updateTabsetPanel(session, "tabs", selected = "nn")}
  })
  
  # 
  #         observeEvent(
  #           eventExpr = input$train,
  #           handlerExpr = {
  #             withProgress(
  #               message = "Entraînement en cours...", value = 1, {
  #                 model = trainModel(input$varOfInterest,input$typeOfMl)
  #               }
  #             )
  #           }
  #         )
  # 

          observeEvent(
            eventExpr = input$metric,
            handlerExpr = {
              updateTabItems(session, "tabs", "resultTab")
            }
          )
}

     # )
   # }
  #)
#}

