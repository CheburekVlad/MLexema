algoBackend = function (input, output, session) {

  observeEvent(
    eventExpr = input$verification,
    handlerExpr = {
      withProgress(
          message = "Recherche des varables d'intérêt...", value = 1, {
          mlVoiResult = RfeMethod(input$repetitionK, input$columnJ, input$Voib,trainData$transformedVoi)
          output$mlVoiResult = renderText(mlVoiResult)
          
          observeEvent(
            eventExpr = input$train,
            handlerExpr = {
              model = trainModel(input$varOfInterest,input$typeOfMl)
              
              
              observeEvent(
                eventExpr = input$metric,
                handlerExpr = {

                  output$mlPlot <- renderPlot(plot(newModel, main=paste("Model Accuracies with", input$typeOfMl)))
                  newVarImp <<- varImp(newModel)
                  output$ml2Plot <- renderPlot(plot(newVarImp, main=paste("Variable Importance with", input$typeOfMl)))
                  updateTabItems(session, "tabs", "resultTab")
                }
              )
            }
          )
        }
      )
    }
  )
}

