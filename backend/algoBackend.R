algoBackend = function (input, output, session) {

          observeEvent(
            eventExpr = input$train,
            handlerExpr = {
              if (!input$typeOfMl == "kmeans"){
              withProgress(
                message = "Entraînement en cours...", value = 1, {
                  model = trainModel(input$varOfInterest,input$typeOfMl)
                }

              )}
              else {
                kmeans_res = kmeans_analysis(read_xlsx(input$fileInput$datapath),input$cluster,input$nstart,input$maxhit)
              }
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

