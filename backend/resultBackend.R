resultBackend = function (input, output, session) {
  # Le resultat de cette fonction est de retourner l'objet output$total.
  # Son contenu depend du methode d'analyse choisi et ne retourne pas les memes resultats 
  # en fonction du methode
  
  # Layout du Kmeans
  observeEvent(input$kmeans,{

    output$verb <- renderText(k_means$acc)
    output$RocCurve <- renderPlot(plot(k_means$roc))

    voiName <- input$varOfInterest
    outputTable = data.frame(
      k_means$conf["Patients"],
      k_means$conf[voiName],
      ifelse(k_means$conf["Predicted"] == 1,"ACD","No ACD")
    )
    colnames(outputTable) = c("Patients", paste(voiName,"(input)"), paste(voiName,"(predicted)"))

    output$predictTable <- renderTable(outputTable)
    output$total <- renderUI(
      fluidPage(
        strong("Prédiction du Kmeans"),
        br(),br(),
        tableOutput("predictTable"),
        
        strong("Precision de clusturing"),
        uiOutput("confMatrix"),
        verbatimTextOutput("verb"),
        
        strong("Courbe ROC"),
        plotOutput('RocCurve')
      )
    )
  })
  
  # Layout du RF et SVM
  observeEvent(ignoreInit = TRUE, c(
      input$metricrf,
      input$metricsvm
    ), {
      output$mlPlot <- renderPlot(plot(newModel, main=paste("Model Accuracies with", method)))
      #newVarImp <<- varImp(newModel)
      #output$ml2Plot <- renderPlot(plot(newVarImp, main=paste("Variable Importance with", input$typeOfMl)))
      
      # Prédiction
      pred <<- predict(newModel,testData)
      voiName <- input$varOfInterest
      outputTable = data.frame(testData$Patients, testData[voiName], pred)
      colnames(outputTable) = c("Patients", paste(voiName,"(input)"), paste(voiName,"(predicted)"))
      output$predictTable <- renderTable(outputTable)
      
      # Matrice de confusion
      newMatrix = confusionMatrix(reference = as.factor(testData[,voiName]), data = as.factor(pred),mode = 'everything')
      #output$confMatrix = renderPrint(newMatrix)
      output$verb = renderPrint(newMatrix)
      
      # ROC
      predROC <- ROCR::prediction(as.numeric(pred), testData[voiName])
      perf <- ROCR::performance(predROC,"tpr", "fpr")
      output$RocCurve = renderPlot(plot(perf))
      output$total <- renderUI(fluidPage(
        strong("Mesure de la pertinence du modèle"),
        br(),
        strong("Genes chioisis:",renderText(paste(input$genes,collapse = " + "))),
        plotOutput("mlPlot"),
        
        strong("Prédiction du modele"),
        br(),br(),
        strong("Prédiction"),
        br(),br(),
        tableOutput("predictTable"),
        
        strong("Matrice de confusion"),
        uiOutput("confMatrix"),
        verbatimTextOutput("verb"),
        
        strong("Courbe ROC"),
        plotOutput('RocCurve'),
        
        textInput('name', 'Nom du fichier:'),
        actionButton("save","Sauvgarder le model")
      ))
    }
  )
  
  # Permet de sauvegarder le model generé pour l'analyse dans le futur, si l'utilisateur
  # considere que le model est utilisable
  observeEvent(
    eventExpr = input$save,
    handlerExpr = {
      saveRDS(newModel,file.path('trainedModel',input$name))
    }
  )
}