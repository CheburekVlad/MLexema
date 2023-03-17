
resultBackend = function (input, output, session) {

  observeEvent(
    eventExpr = input$predict,
    handlerExpr = {

      pred <<- predict(model_rf,testData)
      output$predict <- renderPrint(pred)

      observeEvent(
        eventExpr = input$confMatrice,
        handlerExpr = {

          matrix = confusionMatrix(reference = as.factor(testData$Diagnosis), data = as.factor(pred),mode = 'everything')
          output$confMatrice = renderPrint(matrix)

          observeEvent(
            eventExpr = input$ROC,
            handlerExpr = {

              pred_rocr <- prediction(as.numeric(pred), testData$Diagnosis)
              perf <- performance(pred_rocr,"tpr", "fpr")
              output$RocCurve = renderPlot(plot(perf))

            }
          )

        }
      )
      }
  )



}
