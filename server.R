library(shinydashboard)
library(shiny)
source("Methods/Neuralnet.R")

{
fichiers = fluidRow(
  radioButtons("radio",label = "Format de fichier:", 
  choices = list("Données brutes" = 1, "Données fold change" = 2), selected = 1),
  br(),br(),
  fileInput("fileInput", label = "Input file format",accept = c(".xlsx")),
  br(),br(),uiOutput("previewPanel"))
  
algo = fluidRow(
  column(3, h5("Choix Modèles"),actionButton("new_model", "Création d'un nouveau modèle"),
  br(), br(), 
  selectInput("select_old_model", h5("Utiliser un ancien modèle"), 
  choices = list("SVM 2023" = 1, "Random Forest 2023" = 2, "Neural Network" = 3), selected = 1)),

  column(3, selectInput("select_learning", "Choix du type d'apprentissage",
  choices = list("SVM" = 1, "Random Forest" = 2, "Réseaux de neurones" = 3, "Kmeans" = 4), selected =1)),

  column(3,radioButtons("radio_parameters","Choix des paramètres", 
  choices = list("Automatique rapide" = 1, "Automatique precis" = 2, "Manuelle" = 3),selected = 1),
  numericInput("num_kernel", "Nombre de Kernel", value = list(0,1,2,3,4,5)),
       
  selectInput("select_conditions", "Conditions :", choices = list("Colonne 1" = 1, "Colonne 2"),selected = 1)),

  column(3, h5("Le format d'enregistrement"),actionButton("Format_enregistrement", "csv")))

result = fluidRow(
  uiOutput("result")
)



ui <- dashboardPage(
    dashboardHeader(title = "Molecular diagnosis"),
    dashboardSidebar(
      sidebarMenu(
        
        menuItem("Fichiers", tabName = "fichiers"),
        menuItem("Algorithme", tabName = "algo"),
        menuItem("Résultats", tabName = 'res')
      )),
    
    dashboardBody(
      tabItems(
        tabItem(tabName = "fichiers",fichiers),
        tabItem(tabName = "algo",algo),
        tabItem(tabName = "res"),uiOutput("test"))))


server <- function(input, output) {
  xl = reactiveVal()
  # File selection event
  observeEvent(
    eventExpr = input$fileInput,
    handlerExpr = {
      # Get input file path
      inFile = input$fileInput$datapath
      if (is.null(inFile))
        return(NULL)
      
      # Read the input file
      xl <- readxl::read_excel(inFile)
      xl_short = xl[1:5,]
      
      output$previewPanel <- renderUI({
        fluidPage(
          hr(style = "border-top: 1px solid #000000;"),
          br(),
          strong("Extrait du fichier chargé:"),
          renderTable(xl_short))})
      
      NN = NeuralNet_prediction(xl)
      output$result = renderUI({
        fluidPage(hr("resultats de reseau de neurones"),
                  renderTable(NN))
    }
  )

  })}
}

if(interactive()){
  app = shinyApp(ui = ui,server = server)
  runApp(app)
}  

