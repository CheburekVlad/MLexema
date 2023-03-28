{preproLayout = fluidRow(
  titlePanel("Normalisation des données"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Selectionner le fichier de données", accept = c(".csv")),
      fileInput("file2", "Selectionner le fichier avec les efficacités", accept = c(".csv")),
      
      
      uiOutput("column_selector_1"),
      uiOutput("column_selector_2"),
      
      
      textOutput("selected_columns_1"),
      textOutput("selected_columns_2"),
      
      actionButton("compute", "Normalisation des données"),
      
      
      downloadButton("downloadData", "Enregistre les données normalisée en format CSV"),
      downloadButton("downloadExcel", "Enregistre les données normalisée en format xlsx")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Données", dataTableOutput("table1")),
        tabPanel("Efficacité", dataTableOutput("table2")),
        tabPanel("Données normalisée", tableOutput("table3")),
        tabPanel("Fusion",
                 fileInput("file3", "Selection jeux de données 1", accept = c(".csv")),
                 fileInput("file4", "Selection jeux de données 2", accept = c(".csv")),
                 actionButton("fusion_gene", "Fusion par gène"),
                 actionButton("fusion_patients", "Fusion par patient"))
      )
    )
  )
)
}
