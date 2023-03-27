normalize_by_efficiency <- function(df, eff, liste_gene) {
  
  # Prends un dataframe avec les données d'expression et d'efficacités pour normaliser
  j <-1
  for (i in liste_gene[1]:ncol(df)) {
    col <- df[[i]]
    norm_col <- eff[j,]^(-col)
    colname <- paste0(colnames(df)[i])
    df[[colname]] <- norm_col
    j <- j +1
  }
  # Retourne les tableau de résultat
  return(df)
}
