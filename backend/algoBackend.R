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
            eventExpr = input$train,
            handlerExpr = {
              withProgress(
                message = "Entraînement en cours...", value = 1, {
                  model = trainModel(input$varOfInterest,input$typeOfMl)
                }
              )
            }
          )

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

