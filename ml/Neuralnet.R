library(neuralnet)
library(boot)

#data loading and preproc
df = readxl::read_xlsx("~/Desktop/Projet/20220412 jeu de données RF sans barx2.xlsx")
data = df
df$Diagnosis = ifelse(data$Diagnosis == "ACD",1,0)
partition = 0.7

ind = sample(1:nrow(df),partition*nrow(df))
train = df[ind,]
test = df[-ind,]

target = colnames(df[14])
variables = colnames(df[c(-1,-14)])
form = paste0(target,"~",paste(variables,collapse = "+"))

#internal functions def
mse <- function(actual, predicted) {
  mean((actual - predicted)^2)
}

neuralnet_cv <- function(data, folds) {
  cv_mse <- rep(0, folds)
  for (i in 1:folds) {
    
    set.seed(i)
    ind <- sample(1:nrow(data), size = floor(nrow(data)/folds))
    train <- data[-ind,]
    valid <- data[ind,]
    
    model <- neuralnet(form, data = train, linear.output = FALSE)
    
    # Make predictions on validation set
    predicted <- predict(model, valid[, -14])
    actual <- valid[, 14]
    cv_mse[i] <- mse(actual, predicted)}
  
  mean(cv_mse)
}

cv_acc <- cv.glm(data = train, 
                 glmfit = NULL,
                 K = 5,
                 model = neuralnet,
                 formula = form,
                 mse,
                 hidden = c(10, 5),
                 threshold = 0.01,
                 stepmax = 1e6,
                 rep = 1)

model_test = neuralnet(as.formula(form),
                       data = train,hidden = c(10,5), err.fct = "ce",
                       linear.output = F)
pred = prediction(model,test[,-14])

