normalize_by_efficiency <- function(df, eff, liste_gene) {
  
  # Compute the normalized expression values
  j <-1
  for (i in liste_gene[1]:ncol(df)) {
    col <- df[[i]]
    norm_col <- eff[j,]^(-col)
    colname <- paste0(colnames(df)[i])
    df[[colname]] <- norm_col
    j <- j +1
  }
  # Return the updated data frame with normalized expression values
  return(df)
}