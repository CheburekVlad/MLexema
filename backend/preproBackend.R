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
    result_dt <- sample_ratio(normalized_df, liste_info)
    
    # Display the result dataframe
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
