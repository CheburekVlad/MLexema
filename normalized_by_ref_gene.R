normalized_by_ref_gene <- function(df, liste_info, liste_gene) {
  # Initialize a data frame to store the computed means, including the first columns of info
  norm_df <- df[,liste_info]
  
  # Compute the normalized expression values
  for (i in liste_gene[1]:(ncol(df)-1)) {
    col <- df[[i]]
    ref <- df[,ncol(df)]
    norm_col <- (col)/ref
    colname <- paste0(colnames(df)[i])
    df[[colname]] <- norm_col
    
  }
  # Return the updated data frame with normalized expression values
  df <-df[,!names(df) %in% c("mean_GAPDH_actine", "GAPDH", "Actine")]
  return(df)
}
