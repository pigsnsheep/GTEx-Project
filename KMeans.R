training <- sample(1:56200, size = 56200*0.8)

training.data <- umap.data[training,]
test.data <- umap.data[-training,]

nrow(umap.data)

clustering.algorithm <- kmeans(umap.data, 10, iter.max = 10)

clustering.algorithm

fviz_cluster(clustering.algorithm, umap.data, labelsize = 0)

ggplot(umap.data , aes(x=X1, y=X2)) + geom_point()
