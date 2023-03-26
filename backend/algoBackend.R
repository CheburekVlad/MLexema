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
      selected_option <- input$type
      
      if (selected_option == "Random Forest") {
        updateTabsetPanel(session, "tabs", selected = "rf")
        observeEvent(
          eventExpr = input$train,
          handlerExpr = {
            withProgress(
              message = "Entraînement en cours...", value = 1, {
                model = trainModel(input$varOfInterest,input$typeOfMl)
              })})
      } 
      else if (selected_option == "SVM") {
        updateTabsetPanel(session, "tabs", selected = "svm")
        
        #backend du SVM a mettre ici
        
      } 
      else if (selected_option == "Kmeans") {
        updateTabsetPanel(session, "tabs", selected = "km")
        
        kmeans_res = kmeans_analysis(input$inFile)
        output$km = renderText(kmeans_res[1])
      }
      else if (selected_option == "NeuralNet") {
        updateTabsetPanel(session, "tabs", selected = "nn")
      }
      output$km = renderText(kmeans_res[1])
    }
  )
  observeEvent(input$rf.result, {
    updateTabItems(session, "tabs", "resultTab")
  })
  
  observeEvent(input$svm.result, {
    updateTabItems(session, "tabs", "resultTab")
  })
  
  observeEvent(input$km.result, {
    updateTabItems(session, "tabs", "resultTab")
  })
  
  observeEvent(input$nn.result, {
    updateTabItems(session, "tabs", "resultTab")
  })
  }
  
