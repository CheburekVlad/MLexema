fileBackend = function(input, output, session) {
  # Récupère les noms de fichiers des modèles entrainés
  listModels = as.list(list.files("trainedModel"))
  
  # Sélection du modèle déjà entrainé présent dans le dossier trainedModel
  observeEvent(
    eventExpr = input$load,
    handlerExpr = {
      model <<- readRDS(file.path("trainedModel", input$trainedModel))
    }
  )
  
  # Evènement sélectionnant le fichier d'entrée
  observeEvent(
    eventExpr = input$fileInput,
    handlerExpr = {
      # Obtention du chemin du fichier d'entrée
      inFile = input$fileInput$datapath
      if (is.null(inFile))
        return(NULL)

      vars <- names(readxl::read_excel(inFile))

      # Lecture du fichier d'entrée
      xl <- readxl::read_excel(inFile, n_max = 10)
      output$previewPanel <- renderUI(
        {
          fluidPage(
            hr(style = "border-top: 1px solid #000000;"),
            br(),
            selectInput("varOfInterest", "Choisir une variable d'intérêt", vars, selected=tail(vars,1)),
            br(),
            strong("Extrait du fichier chargé:"),
            renderTable(xl)
          )
        }
      )

      # Exécuter la fonction en cliquant sur le bouton Soumettre
      observeEvent(
        eventExpr = input$submit,
        handlerExpr = {
          result = creationDataset(inFile, input$varOfInterest, input$numPartition)
          output$result = renderPrint(result)

          updateTabItems(session, "tabs", "algoTab")
        })
    })
}