sample_ratio <- function(df, liste_info){
  # séparation des données par CT
  data_groups <- split(df, df[,"CT"]) # values columns
  ratio_df <- data.frame()
  ratio_vec <- vector()
  # Taille des colonnes informative à ignorer
  len_info <- length(liste_info)+1
  len_df <- length(df)
  # calcul du ratio par lignes avec la première lignes dans chaques groupe étant le dénominateur
  if (len_df>len_info){
    for (i in 1:length(data_groups)){
      for (j in 2:length(data_groups[[i]][[(len_info)]])){
        ratio_df_temp <-data_groups[[i]][j,len_info:len_df]/data_groups[[i]][1,len_info:len_df]
        ratio_df <- rbind(ratio_df, ratio_df_temp)
      }
    }
    # Changement de ordre des données pour PATIENTS, DONNEES, DIAGNOSTICS
    df <- df[!duplicated(df[,"PATIENTS"]), ]
    result <- cbind(df[,c("PATIENTS","DIAGNOSIS")], ratio_df)
    fold_change_df <- result[,c(colnames(result)[colnames(result)!='DIAGNOSIS'],'DIAGNOSIS')]
    return(fold_change_df)
  } # Dans le cas où nous avons que une colonne de données calcul du ratio 
  else{
    for (i in 1:length(data_groups)){
      for (j in 2:length(data_groups[[i]][[(len_info)]])){
        ratio_vec_temp <-data_groups[[i]][j,len_info]/data_groups[[i]][1,len_info]
        ratio_vec <- c(ratio_vec, ratio_vec_temp)
      }
    } # Retourne le resultat dans un taleau avec PATIENTS, DONNEES, DIAGNOSTIC
    df <- df[!duplicated(df[,"PATIENTS"]), ]
    result <- cbind(df[,"PATIENTS"], ratio_vec, df[,"DIAGNOSIS"])
    colnames(result) <- c("PATIENTS", colnames(df[len_info]), "DIAGNOSIS")
    fold_change_df <- as.data.frame(result)
    return(fold_change_df)
  }
}
