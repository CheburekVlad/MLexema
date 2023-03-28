algoBackend = function (input, output, session) {

  
  observeEvent(input$trainrf, {
      method <<- 'rf'
      withProgress(
        message = "Entraînement en cours...", value = 1, {
          model <<- trainModel(input$varOfInterest,'rf')
        }
      )
    }
  )

  observeEvent(input$trainsvm, {
    method <<- 'svm'
      withProgress(
        message = "Entraînement en cours...", value = 1, {
          model <<- trainModel(input$varOfInterest,'svm')
        }
      )
    }
  )
  
  observeEvent(input$kmeans,{
    method <<- 'km'
    k_means <<-kmeans_analysis(raw_data,input$clusters,input$nstart,input$iter, input$varOfInterest)
    updateTabItems(session,"tabs","resultTab")
  })
  
  observeEvent(input$metricrf, {
    updateTabItems(session,"tabs","resultTab")
  })
  
  observeEvent(input$metricsvm, {
    updateTabItems(session,"tabs","resultTab")
  })
}  
  

  
