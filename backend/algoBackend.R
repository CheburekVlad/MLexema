algoBackend = function (input, output, session) {

  #Entrainement du model Random Forest
  observeEvent(input$trainrf, {
      method <<- 'rf'
      withProgress(
        message = "Entraînement en cours...", value = 1, {
          model <<- trainModel(input$varOfInterest,method,input$genes)
        }
      )
    }
  )

  #Entrainement du model SVM
  observeEvent(input$trainsvm, {
    method <<- 'svm'
      withProgress(
        message = "Entraînement en cours...", value = 1, {
          model <<- trainModel(input$varOfInterest,method,input$genes)
        }
      )
    }
  )
  
  # Clustering par Kmeans
  observeEvent(input$kmeans,{
    method <<- 'km'
    k_means <<-kmeans_analysis(raw_data,input$clusters,input$nstart,input$iter, input$varOfInterest,input$genes)
    updateTabItems(session,"tabs","resultTab")
  })
  
  # Passage à l'onglet Resultats
  
  observeEvent(input$metricrf, {
    updateTabItems(session,"tabs","resultTab")
  })
  
  observeEvent(input$metricsvm, {
    updateTabItems(session,"tabs","resultTab")
  })
}  
  

  
