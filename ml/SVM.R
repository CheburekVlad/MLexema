library(caret)
library(readxl)

# Vérifier que les données sont séparables linéairement
file = read_xlsx('/home/estelle/Documents/Fac/Master 1/Semestre 2/Projet 15/eczema_data.xlsx')

pca <- prcomp(file[, 2:13], center = TRUE, scale. = TRUE) # Effectuez l'analyse PCA

donnees_pca <- data.frame(pca$x[, 1:2], diagnostique = file$Diagnosis) # Créez un dataframe avec les deux premières composantes principales et la variable diagnostique

ggplot(donnees_pca, aes(x = PC1, y = PC2, color = diagnostique)) +
  geom_point()


# Charger les données
data <- read_xlsx('/home/estelle/Documents/Fac/Master 1/Semestre 2/Projet 15/eczema_data.xlsx')

# Diviser les données en ensembles d'apprentissage et de test
set.seed(123)
trainIndex <- createDataPartition(data$Diagnosis, p = 0.7, list = FALSE)
train <- data[trainIndex, ]
test <- data[-trainIndex, ]

# Normaliser les données
preProcValues <- preProcess(train[,2:13], method = c("center", "scale"))
train[,2:13] <- predict(preProcValues, train[,2:13])
test[,2:13] <- predict(preProcValues, test[,2:13])

# Créer un objet de contrôle
ctrl <- trainControl(method = "repeatedcv", number = 5, repeats = 3)

# Entraîner le modèle SVM
set.seed(123)
model <- train(Diagnosis ~ GPR183*PLEK*IGFL3, data = train, method = "svmRadial",
               trControl = ctrl, preProcess = c("center", "scale"),
               tuneLength = 10)

# Prédire les classes sur l'ensemble de test
predictions <- predict(model, newdata = test)

# Évaluer les performances du modèle
confusionMatrix(data = as.factor(predictions), reference = as.factor(test$Diagnosis))


