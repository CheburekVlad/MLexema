# Initialise l'environnement
source("initialize.R")

# ---------------------------- Interface ----------------------------

# Onglets
source(file.path('ui', 'fileTab.R'))
source(file.path('ui', 'algoTab.R'))
source(file.path('ui', 'resultTab.R'))

ui <- dashboardPage(
  dashboardHeader(title = "Molecular diagnosis"),

  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem("Fichiers",   tabName = "fileTab"),
      menuItem("Algorithme", tabName = "algoTab"),
      menuItem("Résultats",  tabName = 'resultTab')
    )
  ),

  dashboardBody(
    tabItems(
      tabItem(tabName = "fileTab",   fileLayout),
      tabItem(tabName = "algoTab",   algoLayout),
      tabItem(tabName = "resultTab", resultsLayout)
    )
  )
)


# ---------------------------- Serveur ----------------------------

# Backend
source(file.path('backend', 'fileBackend.R'))
source(file.path('backend', 'algoBackend.R'))
source(file.path('backend', 'resultBackend.R'))

server <- function(input, output, session) {
  fileBackend(input, output, session)
  algoBackend(input, output, session)
  resultBackend(input, output, session)
}



shinyApp(ui = ui, server = server)
