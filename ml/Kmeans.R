load_data = function()

df =readxl::read_xlsx("~/Desktop/Projet/20220412 jeu de données RF sans barx2.xlsx")

library(amap)

norma = function(x){
  (x-min(x))/(max(x)-min(x))
}

data = df
Diagnosis = ifelse(df$Diagnosis=="ACD",2,1)
data = data[,c(-1,-14)]
n = apply(data,2,FUN = norma)

pca = dudi.pca

fin = 0
#for (i in 1000:2000){
set.seed(2002)
res = Kmeans(n,method = "pearson", centers = 2,nstart = 5,iter.max = 15)
res$cluster
data.frame(res$cluster,Diagnosis)->b
a = table(b)


fin = (a[1,1]+a[2,2])/(sum(a))
fin


mean(fin)
barplot(fin)
