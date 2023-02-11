# Skip the first 2 rows
 gtx_colon_data <- read.table(skip = 3, "./gene_tpm_2017-06-05_v8_colon_sigmoid.gct")
# gtx_colon_data <- read.table(skip = 3, "./gene_tpm_2017-06-05_v8_adipose_subcutaneous.gct")


#print(row.names(gtx_colon_data))

row.names(gtx_colon_data) <- gtx_colon_data[,2]
#column_to_rownames(gtx_colon_data, "Name")
# XXX: Same gene in multiple rows. For e.g. 5_8S_rRNA
#     Need to use gene id instead of gene name as row name

#print(row.names(gtx_colon_data))

gtx_colon_data_trim <- gtx_colon_data[,-c(1,2,3)]

gtx_colon_data_t <- t(gtx_colon_data_trim)
#gtx_colon_data_t <- gtx_colon_data_t[,-c(1)]
#row.names(gtx_colon_data_t) = gtx_colon_data_t[,1]

# XXX: Only needed in file.table
#gtx_colon_data_t <- gtx_colon_data_t[,-c(1)]

# Error in gtx_colon_data_t[, unlist(lapply(gtx_colon_data_t, is.numeric))] : (subscript) logical subscript too long
#gtx_colon_data_t_numeric <- gtx_colon_data_t[, unlist(lapply(gtx_colon_data_t, is.numeric))]
# Error in colMeans(x, na.rm = TRUE) : 'x' must be numeric

#library(tidyverse) 
#test <- gtx_colon_data_t[c(1:2),c(1:2)]

#test_n <- test %>% mutate_if(is.character, is.numeric)
#test_n[] <- lapply(test, as.numeric)
# Looks like the values are chars

gtx_colon_data_t_pc <- prcomp(gtx_colon_data_t)
summary(gtx_colon_data_t_pc)

# REF: https://tavareshugo.github.io/data-carpentry-rnaseq/03_rnaseq_pca.html#Exploring_correlation_between_genes_and_PCs
pc_loadings <- gtx_colon_data_t_pc$rotation
 
# Install package 'dplyr' for %>% to work
# 'dplyr' might require installing 'tidyverse'

pc_loadings <- pc_loadings %>%
  as_tibble(rownames = "gene")

pc_loadings

# install 'tidyr' for pivot_longer
top_genes <- pc_loadings %>% 
  # select only the PCs we are interested in
  select(gene, PC1, PC2) %>%
  # convert to a "long" format
  pivot_longer(matches("PC"), names_to = "PC", values_to = "loading") %>% 
  # for each PC
  group_by(PC) %>% 
  # arrange by descending order of loading
  arrange(desc(abs(loading))) %>% 
  # take the 10 top rows
  slice(1:10) %>% 
  # pull the gene column as a vector
  pull(gene) %>% 
  # ensure only unique genes are retained
  unique()

top_genes
