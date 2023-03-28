preproBackend <- function(input, output) {
  
  ######################################### Loading and display ###################################################
  
  # Load the CSV file into a dataframe
  data <- reactive({
    req(input$file1)
    df <- read.csv(input$file1$datapath, header = TRUE, stringsAsFactors = FALSE, sep =';',
                   dec = ',', na.strings= c("*","Undetermined " ))
    df
  })
  
  # Load the data from file 2
  efficiency <- reactive({
    req(input$file2)
    eff <- read.csv(input$file2$datapath, header = TRUE)
    eff
  })
  
  # Display raw data
  output$table1 <- renderDT({
    data()
  })
  
  # Display efficiency data
  output$table2 <- renderDT({
    efficiency()
  })
  
  ###############################################################################################################################
  
  ####################################### Selection of the columns #####################################################################
  
  
  # Update the select input for info columns based on the loaded data
  output$column_selector_1 <- renderUI({
    req(data())
    selectInput("column_select_1", "Select a Column for Group 1:", choices = colnames(data()), multiple = TRUE)
  })
  
  # Update the select input for gene columns based on the loaded data
  output$column_selector_2 <- renderUI({
    req(data())
    selectInput("column_select_2", "Select a Column for Group 2:", choices = colnames(data()), multiple = TRUE)
  })
  
  
  
  ####################################################################################################################################
  ################################ Call of the function and display of the result  ####################################################@
  
  # Compute means based on selected columns when button is clicked
  observeEvent(input$compute, {
    req(input$column_select_1, input$column_select_2)
    
    # Select the data columns and id columns
    info_cols <- input$column_select_1
    gene_cols <- input$column_select_2
    
    df <- data()
    eff <- efficiency()
    liste_info <- which(colnames(df) %in% info_cols)
    liste_gene <- which(colnames(df) %in% gene_cols)
    
    # Compute the mean columns
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

# Chargement des fichiers pour fusion
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
  rbind(data1(), data2())
  
  output$fusion_output <- renderTable({
    combined_data()
  })
})

# Fusion et affichage des deux set de données par colonnes
combined_data <- eventReactive(input$fusion_gene, {
  
  cbind(data1(), data2())
  
  output$fusion_output <- renderTable({
    combined_data()
  })
})

  
}
