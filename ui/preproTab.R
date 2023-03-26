{preproLayout = fluidRow(
  titlePanel("Data Normalization App"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Select dataset file", accept = c(".csv")),
      fileInput("file2", "Select efficiency file", accept = c(".csv")),
      
      
      uiOutput("column_selector_1"),
      uiOutput("column_selector_2"),
      
      
      textOutput("selected_columns_1"),
      textOutput("selected_columns_2"),
      
      actionButton("compute", "Compute normalized data"),
      
      
      downloadButton("downloadData", "Download normalized data in CSV Format")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Data", dataTableOutput("table1")),
        tabPanel("Efficiency", dataTableOutput("table2")),
        tabPanel("Normalized data", tableOutput("table3")),
        tabPanel("Fusion data",
                 fileInput("file3", "Select dataset file 1", accept = c(".csv")),
                 fileInput("file4", "Select dataset file 2", accept = c(".csv")),
                 actionButton("fusion_gene", "Fusion of two dataset by genes"),
                 actionButton("fusion_patients", "Fusion of two dataset by patients"))
      )
    )
  )
)}

