{preproLayout = fluidRow(
  titlePanel("App de Normalisation des données"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Selectionner le fichier de données", accept = c(".csv")),
      fileInput("file2", "Selectionner le fichier avec les efficacités", accept = c(".csv")),
      
      
      uiOutput("column_selector_1"),
      uiOutput("column_selector_2"),
      
      
      textOutput("selected_columns_1"),
      textOutput("selected_columns_2"),
      
      actionButton("compute", "Normalisation des données"),
      
      
      downloadButton("downloadData", "Download normalized data in CSV Format")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Données", dataTableOutput("table1")),
        tabPanel("Efficacités", dataTableOutput("table2")),
        tabPanel("Données Normalisés", tableOutput("table3")),
        tabPanel("Fusion des données",
                 fileInput("file3", "Select dataset file 1", accept = c(".csv")),
                 fileInput("file4", "Select dataset file 2", accept = c(".csv")),
                 actionButton("fusion_gene", "Fusion de deux jeux de données par gènes"),
                 actionButton("fusion_patients", "Fusion de deux jeux de données par patients"))
      )
    )
  )
)}

