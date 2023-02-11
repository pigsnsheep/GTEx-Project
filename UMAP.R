#Create a UMAP of the combined data
combined.umap <- umap(everything)

#Plot each gene using the two dimensions
combined.umap.data <- data.frame(combined.umap$layout)
ggplot(combined.umap.data, aes(x=X1,y=X2)) + geom_point()

#List of genes in the distinct cluster
cluster <- filter(combined.umap.data, X2 < -10)
