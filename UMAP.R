#Create a UMAP of the combined data
combined.umap <- umap(everything)

#Plot each gene using the two dimensions (please see the Issue for the image)
combined.umap.data <- data.frame(combined.umap$layout)
ggplot(combined.umap.data, aes(x=X1,y=X2), fill = X2< -10) + geom_point()

#List of genes in the distinct cluster (Gene_Cluster.csv)
cluster1 <- combined.umap.data %>% filter(X2 < -10)
write.csv(cluster1, "Gene_Cluster.csv")

#Visualization of the distinct cluster (please see the Issue for the image)
combined.umap.data$in.cluster <- combined.umap.data$X2 < -10
ggplot(combined.umap.data, aes(x=X1,y=X2, colour = in.cluster)) + geom_point()
