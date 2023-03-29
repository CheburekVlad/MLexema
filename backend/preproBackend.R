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
    fold_change <- sample_ratio(normalized_df, liste_info)
    
    # Display the result dataframe
    output$table3 <- renderTable(fold_change)
    
     # enregistrement sous .csv
    output$downloadData <- downloadHandler(
      filename = function() {
        paste("data_Normalized-", Sys.Date(), ".csv", sep="_")
      },
      content = function(file) {
        write.csv(fold_change, file, rowNames = FALSE)
      }
    )
    
    output$downloadExcel <- downloadHandler(
      filename = function() {
        paste("expression_normalise", Sys.Date(), ".xlsx", sep="_")
      },
      content = function(file){
        write.xlsx(fold_change, file, rowNames = FALSE)
      })
  })
  
 ######################################### Loading and display ###################################################

data1 <- reactive({
  req(input$file3)
  df <- read.csv(input$file3$datapath, header = TRUE)
  df
})

# chargement du deuxième fichier pour fusion
data2 <- reactive({
  req(input$file4)
  eff <- read.csv(input$file4$datapath, header = TRUE)
  eff
})

# Fusion et affichage des deux set de données par lignes 
combined_data <- eventReactive(input$fusion_patients, {
  rbind(data1(), data2())})
output$fusion_output <- renderTable({
  combined_data()})

# Fusion et affichage des deux set de données par colonnes
combined_data <- eventReactive(input$fusion_gene, {
  data1_subset <- data1()[, !names(data1()) %in% c("PATIENTS", "DIAGNOSIS")]
  data2_subset <- data2()[, !names(data2()) %in% c("PATIENTS", "DIAGNOSIS")]
  data_subset <- cbind(data1_subset, data2_subset)
  PATIENTS <- data1()[,"PATIENTS"]
  DIAGNOSIS <-data1()[,"DIAGNOSIS"]
  data_final <- cbind(PATIENTS, data_subset, DIAGNOSIS)
})

output$fusion_output <- renderTable({
  combined_data()
})

# enregistrement sous .csv
output$downloadData <- downloadHandler(
  filename = function() {
    paste("datafusion", Sys.Date(), ".csv", sep="_")
  },
  content = function(file) {
    write.csv(combined_data(), file, row.names = FALSE)
  }
)

# enregistrement sous .excel
output$downloadExcel <- downloadHandler(
  filename = function() {
    paste("datafusion", Sys.Date(), ".xlsx", sep="_")
  },
  content = function(file){
    write.xlsx(combined_data(), file, row.names = FALSE)
  })
}