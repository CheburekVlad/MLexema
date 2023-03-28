kmeans_analysis = function(input_data,clusters=2,nstart = 5,max.iter= 15){
  #data preprocessing
  data = input_data
  diag = data$Diagnosis
  diag_bin = ifelse(diag == "ACD",1,2) 
  normalized_data <- apply(data[,c(-14, -1)], 2, function(x) (x - min(x)) / (max(x) - min(x)))
  
  res = amap::Kmeans(normalized_data,method = "pearson", centers = 2,nstart = 5,iter.max = 15)$cluster
  temp_tab = table(data.frame(res,diag_bin))
  acc = (temp_tab[1,1]+temp_tab[2,2])/sum(temp_tab)
  
  if (acc< 0.25){
    acc = 1 - acc
    fitted = ifelse(res==1,2,1)
  }
  
  conf = data.frame(data$Patients,fitted,diag_bin,diag)
  colnames(conf) = c("Patient","Predicted","Initial","Diagnosis")
  roc = ROCR::performance(ROCR::prediction(conf$Predicted,conf$Diagnosis),"tpr","fpr")
  return(list(conf= conf,roc = roc,acc = acc))
}

plot_placeholder <- function() {
  ggplot() + 
    theme_void() +
    annotate("text", x = 0.5, y = 0.5, label = "Cette figure n'est pas disponible pour Kmeans", size = 8, hjust = 0.5, vjust = 0.5, color = "red")
}

