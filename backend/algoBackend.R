
algoBackend = function (input, output, session) {

  observeEvent(
    eventExpr = input$verification,
    handlerExpr = {
      RFE_result = RFE_method(input$repetition_k,input$Column_j,input$VoI_b,trainData$transformed_VoI)
      output$RFE_result = renderPrint(RFE_result)
    }
  )




}

