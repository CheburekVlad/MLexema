compute_mean_columns <- function(df, liste_info, liste_gene) {
  # Initialise le dataframe et enregistre les première colonnes avec information sur expression
  mean_df <- df[,liste_info]
  
  # Fais un boucle par pairs de colonne et obtient la moyenne par ligne
  for (i in seq(from = liste_gene[1], to = ncol(df), by = 2)) {
    col1 <- df[, i]
    col2 <- df[, i+1]
    mean_col <- rowMeans(data.frame(col1, col2), na.rm = TRUE)# moyenne par colonne avec option qui ignore les NA
    colname <- paste0(colnames(df)[i]) # Création d'un nouvelle colonnes avec le résultat 
    mean_df <- cbind(mean_df, mean_col) # fusion
    colnames(mean_df)[ncol(mean_df)] <- colname # Recupère le nom des colonnes de ancien dataframe
  }
  
  # Retourne le resultat sour forme de tableau 
  return(mean_df)
}
