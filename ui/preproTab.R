{preproLayout = fluidRow(
  titlePanel("Normalisation des données"),

  sidebarLayout(
    sidebarPanel(

      fileInput("file1", "Sélectionner le fichier de données", accept = c(".csv")),
      fileInput("file2", "Sélectionner le fichier avec les efficacités", accept = c(".csv")),


      uiOutput("column_selector_1"),
      uiOutput("column_selector_2"),

      actionButton("compute", "Normalisation des données"),


      downloadButton("downloadData", "Enregistre les données normalisée au format CSV"),
      downloadButton("downloadExcel", "Enregistre données normalisée au format xlsx"),
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Données", dataTableOutput("table1")),
        tabPanel("Efficacité", dataTableOutput("table2")),
        tabPanel("Données normalisée", tableOutput("table3")),
        tabPanel("Fusion",
                 fileInput("file3", "Sélection jeu de données 1", accept = c(".csv")),
                 fileInput("file4", "Sélection jeu de données 2", accept = c(".csv")),
                 actionButton("fusion_gene", "Fusion par gènes"),
                 actionButton("fusion_patients", "Fusion par patient"),
                 tableOutput("fusion_output"))
      )
    )
  )
)}