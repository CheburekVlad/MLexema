
predictionBackend = function (input, output, session) {

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


      observeEvent(
      eventExpr = input$prediction,
      handlerExpr = {
        prediction = predict(modele,xlPred)
        output$prediction1 = renderPrint(prediction)

        outputTable = data.frame(xlPred$Patients, prediction)
        colnames(outputTable) = c("Patients", "Diagnosis")

        output$prediction1 <- renderTable(outputTable)
      }
    )
    }
      )

  }








