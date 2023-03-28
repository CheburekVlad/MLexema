# Initialise l'environnement
source("initialize.R")

# ---------------------------- Interface ----------------------------

# Onglets
source(file.path('ui', 'fileTab.R'))
source(file.path('ui', 'algoTab.R'))
source(file.path('ui', 'resultTab.R'))
source(file.path('ui', 'predictionTab.R'))
source(file.path('ui', 'preproTab.R'))

ui <- dashboardPage(
  dashboardHeader(title = "Molecular diagnosis"),

  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem("Fichiers",  icon = icon("folder"), startExpanded = TRUE,
        menuSubItem("Normalisation données brutes", tabName = "preproTab"),
        menuSubItem("Chargement données", tabName = "fileTab")
      ),
      
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
        tabItem(tabName = "preproTab", preproLayout),
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
source(file.path('backend', 'preproBackend.R'))

server <- function(input, output, session) {
  fileBackend(input, output, session)
  algoBackend(input, output, session)
  resultBackend(input, output, session)
  predictionBackend(input, output, session)
  preproBackend(input, output)
}



shinyApp(ui, server)
