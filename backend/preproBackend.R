preproBackend <- function(input, output) {
  
  ######################################### chargement des données et présentation ###################################################
  
  # Chargement d'un fichier csv contenant les données
  data <- reactive({
    req(input$file1)
    df <- read.csv(input$file1$datapath, header = TRUE, stringsAsFactors = FALSE, sep =';',
                   dec = ',', na.strings= c("*","Undetermined " ))
    df
  })
  
  # Chargement d'un fichier csv avec les efficacités
  efficiency <- reactive({
    req(input$file2)
    eff <- read.csv(input$file2$datapath, header = TRUE)
    eff
  })
  
  # Permet de faire apparaîtres les données
  output$table1 <- renderDT({
    data()
  })
  
  # Permer de faire apparaitres les efficacités
  output$table2 <- renderDT({
    efficiency()
  })
  
  ###############################################################################################################################
  
  ####################################### Sélection des catégories de colonnes #####################################################################
  
  
  # Mise à jour des colonnes selectionnés, cas des colonnes avec informations
  output$column_selector_1 <- renderUI({
    req(data())
    selectInput("column_select_1", "Selection colonnes informatives:", choices = colnames(data()), multiple = TRUE)
  })
  
  # Mise à jour des colonnes selectionnées, cas de colonnes avec l'expressions des gènes
  output$column_selector_2 <- renderUI({
    req(data())
    selectInput("column_select_2", "Selection des colonnes avec expressions des gènes :", choices = colnames(data()), multiple = TRUE)
  })
  
  
  
  ####################################################################################################################################
  ################################ Appelle des fonctions et présentation des résultats  ####################################################@
  
  # Active le processus de normalisation après appui du bouton 
  observeEvent(input$compute, {
    req(input$column_select_1, input$column_select_2)
    
    # Enregistre les indices des colonnes selectionnés plus haut
    info_cols <- input$column_select_1
    gene_cols <- input$column_select_2
    
    df <- data()
    eff <- efficiency()
    liste_info <- which(colnames(df) %in% info_cols)
    liste_gene <- which(colnames(df) %in% gene_cols)
    
    # Normalisation des données avec les fonctions 
    mean_df <- compute_mean_columns(df, liste_info, liste_gene)
    efficiency_df <- normalize_by_efficiency(mean_df, eff, liste_gene)
    efficiency_df$mean_GAPDH_actine <- (efficiency_df$GAPDH + efficiency_df$Actine)/2
    normalized_df <- normalized_by_ref_gene(efficiency_df, liste_info, liste_gene)
    result_dt <- sample_ratio(normalized_df, liste_info)
    
    # Affichage du tableau de resultat
    output$table3 <- renderTable(result_dt)
  })
  
  
  # doesn't work 
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("data_Normalized-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(reactive({normalized_df}), file)
    }
  )
}
