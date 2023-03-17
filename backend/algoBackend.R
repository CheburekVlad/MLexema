
algoBackend = function (input, output, session) {

  observeEvent(
    eventExpr = input$verification,
    handlerExpr = {
      RFE_result = RFE_method(input$repetition_k,input$Column_j,input$VoI_b,trainData$transformed_VoI)
      output$RFE_result = renderPrint(RFE_result)

      observeEvent(
        eventExpr = input$train,
        handlerExpr = {
          train = trainModelRF(input$var_of_interest,c(input$varestimate),input$typeOfMl) #input$var_of_interest,


          observeEvent(
            eventExpr = input$metric,
            handlerExpr = {

              output$ml_plot <- renderPlot( plot(model_rf, main="Model Accuracies with randomforest") )
              varimp_rf <<- varImp(model_rf)
              output$ml2_plot <- renderPlot(plot(varimp_rf, main="Variable Importance with rf"))
              updateTabItems(session, "tabs", "resultTab")


            }
          )
        }
      )
    }
  )
}

