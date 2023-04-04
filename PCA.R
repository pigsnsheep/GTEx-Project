data.pca <- prcomp(test_data)



  
fviz_nbclust(tsne_data2[sample(1:50293, size = 1000),], kmeans, method = "wss", k.max = 20)


pca2 <- pca2[rowSums(is.na(pca2)) == 0, ] 

pca2<- pca$x[,c(1,2)]


fviz_nbclust(pca2[sample(1:56200, size = 1000),], kmeans, method = "wss", k.max = 20)

pca2.kmeans <- kmeans(pca2, 7, iter.max = 15)


fviz_cluster(pca2.kmeans, pca2, labelsize = 0)
  
ggplot(pca2, aes(x=PC1, y=PC2)) + geom_point()


fviz_eig(data.pca, addlabels = TRUE)

max(pca2.kmeans$withinss)/sum(pca2.kmeans$withinss)

autoplot(data.pca, loadings = TRUE)

