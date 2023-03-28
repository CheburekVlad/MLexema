compute_mean_columns <- function(df, liste_info, liste_gene) {
  # Initialize a data frame to store the computed means, including the first 4 columns
  mean_df <- df[,liste_info]
  
  # Loop through pairs of columns and compute the mean expression for each row
  for (i in seq(from = liste_gene[1], to = ncol(df), by = 2)) {
    col1 <- df[, i]
    col2 <- df[, i+1]
    mean_col <- rowMeans(data.frame(col1, col2), na.rm = TRUE)# Compute the mean expression for each row
    colname <- paste0(colnames(df)[i]) # Generate a new column with gene name for the computed mean column
    mean_df <- cbind(mean_df, mean_col) # fusion
    colnames(mean_df)[ncol(mean_df)] <- colname # Set the name of the new mean column
  }
  
  # Return the final data frame with the computed means
  return(mean_df)
}
