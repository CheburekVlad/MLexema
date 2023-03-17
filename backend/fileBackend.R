
fileBackend = function(input, output, session) {
  # Récupère les noms de fichiers des modèles entrainés
  listeModeles = as.list(list.files("trainedModel"))
  
  # Sélection du modèle déjà entrainé présent dans le dossier trainedModel
  observeEvent(
    eventExpr = input$load,
    handlerExpr = {
      modele <<- readRDS(file.path("trainedModel", input$trainedModel))
    }
  )
  
  # File selection event
  observeEvent(
    eventExpr = input$fileInput,
    handlerExpr = {
      # Get input file path
      inFile = input$fileInput$datapath
      if (is.null(inFile))
        return(NULL)

      vars <- names(readxl::read_excel(inFile))

      # Read the input file
      xl <- readxl::read_excel(inFile, n_max = 10)
      output$previewPanel <- renderUI(
        {
          fluidPage(
            hr(style = "border-top: 1px solid #000000;"),
            br(),
            selectInput("var_of_interest", "Choisir une variable d'intérêt", vars, selected=tail(vars,1)),
            br(),
            strong("Extrait du fichier chargé:"),
            renderTable(xl)
          )
        }
      )

      # Run function on submit button click
      observeEvent(
        eventExpr = input$submit,
        handlerExpr = {
          result = creation_dataset(inFile, input$var_of_interest, input$num_partition)
          output$result = renderPrint(result)

          #output$previewData= renderUI(
          #  {
          #    fluidPage(
          #      strong("test variable"),
          #      renderTable(testData),
          #      renderTable(trainData)
          #    )
          #  }
          #)

          updateTabItems(session, "tabs", "algoTab")

          #Ce code permet lors du clique sur le bouton d'affichier directement les résultats dans la table résultat
          #source(file = 'test_script.R', local=TRUE)
          #output$ml_result <- renderText({ test_script_output })
          #output$ml_plot <- renderPlot({ expr=plot(x,y) })
          #updateTabItems(session, "tabs", "resultTab")
        })
    })
}
