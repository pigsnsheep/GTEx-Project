#Read the data
data <- read.table("../../../Combined.gct", skip = 3)

#Splitting the gene names from the rest of the data
data.labels <- data[,c(1,2)]
data.numeric <- data[,-c(1,2)]

#Log transformation to remove the skew
data.numeric <- log10(data.numeric)


#REDUCING BY ROW MEANS (genes)

#Calculate row means
data.means <- data.frame(rowMeans(data.numeric))
data.means <- na.omit(data.means)


#Renaming row mean columns for simplicity in visualizations
colnames(data.means) <- c("x")



#New visualization of the data (note the removed skew)
ggplot(data.means, aes(x=x)) + geom_histogram(bins=60)

#Length of the row-reduced dataset
str(dplyr::filter(data.means, x > 0))



#Cutting off genes with a low expression value of less than 1, industry standard. (log(1) = 0)
data.numeric$means <- data.means
data.rreduced <- dplyr::filter(data.numeric, means > 0)
str(data.rreduced)

#REDUCING BY COLUMN MEANS (samples)

#Calculating column means on the data set
data.colmeans <- data.frame(colMeans(data.rreduced))


colnames(data.colmeans) <- c("x")

#Determining a cutoff for col means (1)
ggplot(data.colmeans, aes(x=x)) + geom_histogram(bins=60)

#Plotting with the cutoff
ggplot(data.colmeans, aes(x=x, fill = x>1)) + geom_histogram(bins=60)  + scale_fill_manual(name = 'Mean > 1', values = setNames(c('red','green'),c(T, F)))

#Getting the column names of the kept columns
data.topcolmeans <- t(dplyr::filter(data.colmeans, x > 1))


#Final cleaning of the data
data.cleaned <- data.rreduced[,colnames(data.topcolmeans)]

#Removing the temporary "means" column
data.final = subset(data.cleaned, select = -c(means))







