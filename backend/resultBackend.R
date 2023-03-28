resultBackend = function (input, output, session) {
  observeEvent(input$kmeans,{
    output$mlPlot = renderPlot(plot_placeholder())
    output$verb <- renderText(k_means$acc)
    output$RocCurve <- renderPlot(plot(k_means$roc))
    output$predictTable <- renderTable(k_means$conf)
  })
  
  observeEvent(input$metricrf, {
      output$mlPlot <- renderPlot(plot(newModel, main=paste("Model Accuracies with", method)))
      #newVarImp <<- varImp(newModel)
      #output$ml2Plot <- renderPlot(plot(newVarImp, main=paste("Variable Importance with", input$typeOfMl)))
      
      # Prédiction
      pred <<- predict(newModel,testData)
      voiName <- input$varOfInterest
      outputTable = data.frame(testData$Patients, testData[voiName], pred)
      colnames(outputTable) = c("Patients", "Diagnosis (input)", "Diagnosis (predicted)")
      
      output$predictTable <- renderTable(outputTable)
      
      # Matrice de confusion
      newMatrix = confusionMatrix(reference = as.factor(testData$Diagnosis), data = as.factor(pred),mode = 'everything')
      #output$confMatrix = renderPrint(newMatrix)
      output$verb = renderPrint(newMatrix)
      
      # ROC
      predROC <- ROCR::prediction(as.numeric(pred), testData$Diagnosis)
      perf <- ROCR::performance(predROC,"tpr", "fpr")
      output$RocCurve = renderPlot(plot(perf))
    }
  )
  observeEvent(input$metricsvm, {
    output$mlPlot <- renderPlot(plot(newModel, main=paste("Model Accuracies with", method)))
    #newVarImp <<- varImp(newModel)
    #output$ml2Plot <- renderPlot(plot(newVarImp, main=paste("Variable Importance with", input$typeOfMl)))
    
    # Prédiction
    pred <<- predict(newModel,testData)
    voiName <- input$varOfInterest
    outputTable = data.frame(testData$Patients, testData[voiName], pred)
    colnames(outputTable) = c("Patients", "Diagnosis (input)", "Diagnosis (predicted)")
    
    output$predictTable <- renderTable(outputTable)
    
    # Matrice de confusion
    newMatrix = confusionMatrix(reference = as.factor(testData$Diagnosis), data = as.factor(pred),mode = 'everything')
    #output$confMatrix = renderPrint(newMatrix)
    output$verb = renderPrint(newMatrix)
    
    # ROC
    predROC <- ROCR::prediction(as.numeric(pred), testData$Diagnosis)
    perf <- ROCR::performance(predROC,"tpr", "fpr")
    output$RocCurve = renderPlot(plot(perf))
  }
  )
  
  observeEvent(
    eventExpr = input$save,
    handlerExpr = {
      saveRDS(newModel,file.path('trainedModel',input$name))
    }
  )
}