resultBackend = function (input, output, session) {

  observeEvent(
    eventExpr = input$metric,
    handlerExpr = {
      if (!input$typeOfMl =='kmeans'){
      output$mlPlot <- renderPlot(plot(newModel, main=paste("Model Accuracies with", input$typeOfMl)))
      #newVarImp <<- varImp(newModel)
      #output$ml2Plot <- renderPlot(plot(newVarImp, main=paste("Variable Importance with", input$typeOfMl)))
      }
      else {output$mlPlot = print("Not possible for kmeans")}
      # Prédiction
      # pred <<- predict(newModel,testData)
      # voiName <- input$varOfInterest
      # outputTable = data.frame(testData$Patients, testData[voiName], pred)
      # colnames(outputTable) = c("Patients", "Diagnosis (input)", "Diagnosis (predicted)")
      #
      # output$predictTable <- renderTable(outputTable)
      #
      # # Matrice de confusion
      # newMatrix = confusionMatrix(reference = as.factor(testData$Diagnosis), data = as.factor(pred),mode = 'everything')
      # #output$confMatrix = renderPrint(newMatrix)
      # output$verb = renderPrint(newMatrix)
      #
      # # ROC
      # predROC <- prediction(as.numeric(pred), testData$Diagnosis)
      # perf <- performance(predROC,"tpr", "fpr")
      # output$RocCurve = renderPlot(plot(perf))

    }
  )

  observeEvent(
    eventExpr = input$save,
    handlerExpr = {
      saveRDS(newModel,file.path('trainedModel',input$name))
    }
  )
}
