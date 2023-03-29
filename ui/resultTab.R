resultsLayout = fluidRow(
  textOutput("Resultats d'analyse"),
  
  # La visualisation des resultats depend du type d'analyse, l'objet de visualisation total
  # sera donc different. Voir son description dans resultBackend.R
  uiOutput("total")
)