
predictionBackend = function (input, output, session) {
  # Cherche l'événement de chargement du fichier  
  observeEvent(
    eventExpr = input$fileInputPred,
    handlerExpr = {
      # Get input file path
      inFilePred = input$fileInputPred$datapath
      if (is.null(inFilePred))
        return(NULL)

      # Read the input file
      xlPred <- readxl::read_excel(inFilePred, n_max = 100)
      output$previewPanelPrediction <- renderUI(
        {
          fluidPage(
            hr(style = "border-top: 1px solid #000000;"),
            br(),
            strong("Extrait du fichier chargé:"),
            renderTable(xlPred)
          )
        }
      )

      # Attends l'événement clique sur le bouton prediction, 
      observeEvent(
      eventExpr = input$prediction,
      handlerExpr = {
        # Appel la fonction prediction 
        prediction = predict(model,xlPred)
        output$prediction1 = renderPrint(prediction)
        # Permet le rendu des résultats 
        outputTable = data.frame(xlPred[1], prediction)
        colnames(outputTable) = c("Patients", "Diagnosis")

        output$prediction1 <- renderTable(outputTable)
      }
    )
    }
      )

  }








