install.packages("Rtsne")
install.packages("ggplot2")

# Load the required packages
library(Rtsne)
library(ggplot2)


tsne <- Rtsne(unique(test_data))

  tsne_data <- data.frame(x = tsne$Y[,1], y = tsne$Y[,2])

ggplot(tsne_data, aes(x=x,y=y)) + geom_point()

tsne.clustering <- kmeans(tsne_data, 14, iter.max = 10)

fviz_cluster(tsne.clustering, tsne_data, labelsize = 0)

indices <- 

tsne_data[indices,]

fviz_nbclust(tsne_data2[sample(1:50293, size = 1000),], kmeans, method = "wss", k.max = 20)

help("fviz_nbclust")

str(tsne_data)

tsne_data2 <- tsne_data[rowSums(is.na(tsne_data)) == 0, ] 

tsne.clustering$cluster[1]

max(tsne.clustering$size)

tsne_data$cluster <- tsne.clustering$cluster

sam <- read.table("sample.gct", skip = 3)

gene_means <- data.frame(rowMeans2(data.matrix(test_data)))

gene_means$rowMeans2.data.matrix.test_data..

max(gene_means$rowMeans2.data.matrix.test_data..)

ggplot(dplyr::filter(gene_means, rowMeans2.data.matrix.test_data.. < 100), aes(x=rowMeans2.data.matrix.test_data..)) + geom_histogram()



??rowMeans
