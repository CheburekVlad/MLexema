
{ algoLayout = fluidRow(

#  column(3, h5("Choix Modèles"),actionButton("new_model", "Création d'un nouveau modèle"),
#
#         br(), br(),
#
#         #sélection d'un modèle pré-existant
#         selectInput("select_old_model", h5("Utiliser un ancien modèle"),
#                     choices = list("SVM 2023" = 1, "Random Forest 2023" = 2, "Neural Network" = 3), selected = 1)),
#
#  #sélection du type de modèle à entraîner
#  column(3, selectInput("select_learning", "Choix du type d'apprentissage",
#                        choices = list("SVM" = 1, "Random Forest" = 2, "Réseaux de neurones" = 3, "Kmeans" = 4), selected =1)),
#
#  #sélection des paramètres d'entraînement
#  column(3,radioButtons("radio_parameters","Choix des paramètres",
#                        choices = list("Automatique rapide" = 1, "Automatique precis" = 2, "Manuelle" = 3),selected = 1),
#         numericInput("num_kernel", "Nombre de Kernel", value = list(0,1,2,3,4,5)),
#         #sélection de la condition spécifique
#         selectInput("select_conditions", "Conditions :", choices = list("Colonne 1" = 1, "Colonne 2"),selected = 1)),
#
#  #sélection du format d'enregistrement
#  column(3, h5("Format d'enregistrement"),actionButton("Format_enregistrement", "csv")),
#  br(),br(),br(),

  strong("1) Estimation des meilleurs variables pour la construction du modèle"),
  br(),br(),
  numericInput("repetition_k", "Nombre de répétition pour l'analyse des variables importantes", value = 5, min = 0, max = 10),
  numericInput("Column_j", "Numéro de la dernière colonne prise en compte", value = 13 , min = 1, max = 100),
  numericInput("VoI_b", "Nombre de variable importante minimum que l'on souhaite en sortie", value = 3, min = 0, max = 10),

  actionButton("verification", "Analyse"),
  br(),br(),br(),
  strong("Variables d'intérêt identifiées : "),
  textOutput("mlVoiResult"),

  strong("2) Entraînement des modèles"),

  textInput("typeOfMl", label = h3("Text input"), value = "rf"),

  column(1,actionButton("train", "Entraînement")),
  column(4,actionButton("metric","Analyse des modèles")),

  #uiOutput("previewData")

  )







}
