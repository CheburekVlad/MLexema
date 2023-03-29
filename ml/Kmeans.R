#' Fonction dédiée au clustering des données avec amap::Kmeans(), qui est une version un peu
#' plus prcis que base::kmeans()

kmeans_analysis = function(input_data, clusters, nstart, max.iter, voiName, genes){
  
  #data preprocessing
  data = input_data
  diag = data[,voiName]
  
  diag_bin = ifelse(diag == "ACD",1,2)
  # Au cas ou les fonction de preprocessing seront modifiées il faut remplacer "ACD" par
  # le string qui est utilisé pour decrire la condition allergique
  
  #Normalisation de données
  normalized_data <- apply(data[,c(-1,-length(colnames(input_data)))], 2, function(x) (x - min(x)) / (max(x) - min(x)))
  
  #Clustering
  res = amap::Kmeans(normalized_data,method = "pearson", centers = clusters, nstart = nstart,iter.max = max.iter)$cluster
  temp_tab = table(data.frame(res,diag_bin))
  acc = (temp_tab[1,1]+temp_tab[2,2])/sum(temp_tab)
  
  # Kmeans determine les numeros du clusters aleatoirement,
  # il est crucial de remplacer ces numeros au cas ou le vrai numerau est associé au cluster
  # inverse et inversement
  if (acc< 0.25){
    acc = 1 - acc
    fittedV = ifelse(res==1,2,1)
  } else {
    fittedV = res
  }
  
  #Definition des objets que la fonction retourne
  conf = data.frame(data[,1],fittedV,diag_bin,diag)
  colnames(conf) = c("Patients","Predicted","Initial","Diagnosis")
  roc = ROCR::performance(ROCR::prediction(conf$Predicted,conf[,voiName]),"tpr","fpr")
  
  return(list(conf= conf,roc = roc,acc = acc))
}
