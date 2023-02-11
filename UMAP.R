#Create a UMAP of the combined data
combined.umap <- umap(everything)

#Plot each gene using the two dimensions (Image in "Results")
combined.umap.data <- data.frame(combined.umap$layout)
ggplot(combined.umap.data, aes(x=X1,y=X2), fill = X2< -10) + geom_point()

#List of genes in the distinct cluster (csv in "Results")
cluster1 <- filter(combined.umap.data, X2 < -10)

#Visualization of the distinct cluster (Image in "Results")
combined.umap.data$in.cluster <- combined.umap.data$X2 < -10
ggplot(combined.umap.data, aes(x=X1,y=X2, colour = in.cluster)) + geom_point()
