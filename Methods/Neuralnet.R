NeuralNet_prediction = function(xls){
  library(neuralnet)
  xls = as.data.frame(xls)
  #data preparation
  data = xls[,2:14]
  patients = xls[['Patients']]
  row.names(data) = patients
  data$Diagnosis[data$Diagnosis=='No ACD']<-0
  data$Diagnosis[data$Diagnosis=='ACD']<-1
  
  #Data normalisation
  norma =function(x){
    x <- (x-min(x))/(max(x)-min(x))
  }
  n_data = apply(data[,-13],2,norma)
  tot = data.frame(data[,13],n_data)
  ind = sample(2,nrow(tot),replace =T, prob = c(0.7,0.3))
  training = tot[ind==1,]
  testing = tot[ind==2,]
  
  N = neuralnet(data...13.~IGFL3+PLEK+HLADRA+IL15+GPR183+CD8a+GrzB+GLNY+CD69+INFg+CXCL10+CD4,
                data=training,
                hidden=10,
                err.fct = "ce",
                linear.output = F)
  
  output = compute(N,testing)
  pre_diag = ifelse(output$net.result>0.5,1,0)
  comp = table(pre_diag[,2],testing$data...13.)
  
  return(comp)
}
