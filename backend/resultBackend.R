resultBackend = function (input, output, session) {

  observeEvent(
    eventExpr = input$predict,
    handlerExpr = {

      pred <<- predict(newModel,testData)
      outputTable = data.frame(testData$Patients, pred)
      colnames(outputTable) = c("Patients", "Diagnosis")

      output$predictTable <- renderTable(outputTable)

      observeEvent(
        eventExpr = input$confMatrix,
        handlerExpr = {

          newMatrix = confusionMatrix(reference = as.factor(testData$Diagnosis), data = as.factor(pred),mode = 'everything')
          output$confMatrix = renderPrint(newMatrix)

          observeEvent(
            eventExpr = input$ROC,
            handlerExpr = {

              predROC <- prediction(as.numeric(pred), testData$Diagnosis)
              perf <- performance(predROC,"tpr", "fpr")
              output$RocCurve = renderPlot(plot(perf))

              observeEvent(
                eventExpr = input$save,
                handlerExpr = {

                  saveRDS(newModel,file.path('trainedModel',input$name))

                })

              }
            )
        }
      )
    }
  )
}
