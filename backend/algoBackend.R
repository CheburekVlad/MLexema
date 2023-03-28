algoBackend = function (input, output, session) {

 
  # observe({
  #   print("observing")
  #   selected_option = type()
  #     if (selected_option == "Random Forest") {
  #       updateTabsetPanel(session, "tabs", selected = "rf")
  #       print("rf")
  #     }
  #     else if (selected_option == "svm") {
  #       updateTabsetPanel(session, "tabs", selected = "svm")
  #       print("svm")
  #     }   
  #     else if (selected_option == "Kmean") {
  #       updateTabsetPanel(session, "tabs", selected = "km")
  #     }
  #       # kmeans_res = kmeans_analysis(input$inFile)
  #       # output$km = renderText(kmeans_res[1])
  #     
  #     else if (selected_option == "NeuralNet") {
  #       updateTabsetPanel(session, "tabs", selected = "nn")
  #     }
  # 
  # 
  #   })
  
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
    k_means <<-kmeans_analysis(raw_data,input$clusters,input$nstart,input$iter)
    updateTabItems(session,"tabs","resultTab")
  })
  
  observeEvent(input$metricrf, {
    updateTabItems(session,"tabs","resultTab")
  })
  
  observeEvent(input$metricsvm, {
    updateTabItems(session,"tabs","resultTab")
  })
}  
  

  
