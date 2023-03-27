normalized_by_ref_gene <- function(df, liste_info, liste_gene) {
  # Initialisation du tableau et enregistrement des colonnes contenant les infirmation sur les données
  norm_df <- df[,liste_info]
  
  # Fais une boucle qui calcul la nouvelle valeurs d'expression après noramlisation par un gène de ménage
  for (i in liste_gene[1]:(ncol(df)-1)) {
    col <- df[[i]]
    ref <- df[,ncol(df)]
    norm_col <- (col)/ref
    colname <- paste0(colnames(df)[i])
    df[[colname]] <- norm_col
    
  }
  # Retourne le resultat final sans les colonnes de GAPDH et Actine
  df <-df[,!names(df) %in% c("mean_GAPDH_actine", "GAPDH", "Actine")]
  return(df)
}
