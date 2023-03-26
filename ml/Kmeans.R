kmeans_analysis = function(input_data){
  #data preprocessing
  data = input_data
  diag = ifelse(data$Diagnosis=="ACD",2,1)
  normalized_data <- apply(data[,c(-14, -1)], 2, function(x) (x - min(x)) / (max(x) - min(x)))
  
  res = amap::Kmeans(normalized_data,method = "pearson", centers = 2,nstart = 5,iter.max = 15)
  res_table <- data.frame(res$cluster,diag)
  res_score <- (res_table[1,1]+res_table[2,2])/(sum(res_table))
  if (res_score< 0.25){
    res_score = 1 - res_score
    res_table[,1] = ifelse(res_table[,1]==1,2,1)
  }
  
  return(list(df = res_table,acc = res_score))
  }

