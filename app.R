# Initialise l'environnement
source("initialize.R")
library(shinyjs)

# ---------------------------- Interface ----------------------------

# Onglets
source(file.path('ui', 'fileTab.R'))
source(file.path('ui', 'algoTab.R'))
source(file.path('ui', 'resultTab.R'))
source(file.path('ui', 'predictionTab.R'))

ui <- dashboardPage(
  dashboardHeader(title = "Molecular diagnosis"),

  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem("Fichiers",  icon = icon("folder"), tabName = "fileTab"),
      
      menuItem("Entraînement", icon = icon("gear"), startExpanded = TRUE,
        menuSubItem("Algorithme", tabName = "algoTab"),
        menuSubItem("Résultats",  tabName = 'resultTab')),
      
      menuItem("Prédiction", icon = icon("check"), tabName = 'predictionTab')
    )
  ),

  dashboardBody(
    fluidRow(
      style='padding:2em;',
      tabItems(
        tabItem(tabName = "fileTab",   fileLayout),
        tabItem(tabName = "algoTab",   algoLayout),
        tabItem(tabName = "resultTab", resultsLayout),
        tabItem(tabName = "predictionTab", predictionLayout)
      )
    )
  )
)



# ---------------------------- Serveur ----------------------------

# Backend
source(file.path('backend', 'fileBackend.R'))
source(file.path('backend', 'algoBackend.R'))
source(file.path('backend', 'resultBackend.R'))
source(file.path('backend', 'predictionBackend.R'))

server <- function(input, output, session) {
  fileBackend(input, output, session)
  algoBackend(input, output, session)
  resultBackend(input, output, session)
  predictionBackend(input, output, session)
}



shinyApp(ui, server)
