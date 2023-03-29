kmeans_analysis = function(input_data,clusters=2,nstart = 5,max.iter= 15,voiName,genes){
  #data preprocessing
  data = input_data
  diag = data[,voiName]
  diag_bin = ifelse(diag == "ACD",1,2) 
  normalized_data <- apply(data[,c(-1,-length(colnames(input_data)))], 2, function(x) (x - min(x)) / (max(x) - min(x)))
  
  res = amap::Kmeans(normalized_data,method = "pearson", centers = 2,nstart = 5,iter.max = 15)$cluster
  temp_tab = table(data.frame(res,diag_bin))
  acc = (temp_tab[1,1]+temp_tab[2,2])/sum(temp_tab)
  
  if (acc< 0.25){
    acc = 1 - acc
    fittedV = ifelse(res==1,2,1)
  } else {
    fittedV = res
  }

  conf = data.frame(data[,1],fittedV,diag_bin,diag)
  colnames(conf) = c("Patients","Predicted","Initial","Diagnosis")
  roc = ROCR::performance(ROCR::prediction(conf$Predicted,conf[,voiName]),"tpr","fpr")
  return(list(conf= conf,roc = roc,acc = acc))
}
