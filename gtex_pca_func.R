get_top_k_genes <- function(file_name, top_k) {
  # Skip the first 2 rows
  # gtx_colon_data <- read.table(skip = 3, "./gene_tpm_2017-06-05_v8_colon_sigmoid.gct")
  #gtx_colon_data <- read.table(skip = 3, "./gene_tpm_2017-06-05_v8_adipose_subcutaneous.gct")
  gtx_data <- read.table(skip = 3, paste("./", file_name, sep=""))
  
  # Error in read.table(header = TRUE, "./gene_tpm_2017-06-05_v8_colon_sigmoid.gct") : more columns than column names
  #gtx_colon_data <- read.table(skip = 3, "./gene_tpm_2017-06-05_v8_colon_sigmoid.gct")
  
  #gtx_colon_data <- read.delim("./gene_tpm_2017-06-05_v8_colon_sigmoid.noheaders.gct")
  #head(gtx_colon_data)
  
  # Set row name to 1st col
  # Remove 2nd col (description)
  
  #print(row.names(gtx_colon_data))
  
  row.names(gtx_data) <- gtx_data[,2]
  #column_to_rownames(gtx_colon_data, "Name")
  # XXX: Same gene in multiple rows. For e.g. 5_8S_rRNA
  #     Need to use gene id instead of gene name as row name
  
  #print(row.names(gtx_colon_data))
  
  gtx_data_trim <- gtx_data[,-c(1,2,3)]
  
  gtx_data_t <- t(gtx_data_trim)
  #gtx_colon_data_t <- gtx_colon_data_t[,-c(1)]
  #row.names(gtx_colon_data_t) = gtx_colon_data_t[,1]
  
  # XXX: Only needed in file.table
  #gtx_colon_data_t <- gtx_colon_data_t[,-c(1)]
  
  # Error in gtx_colon_data_t[, unlist(lapply(gtx_colon_data_t, is.numeric))] : (subscript) logical subscript too long
  #gtx_colon_data_t_numeric <- gtx_colon_data_t[, unlist(lapply(gtx_colon_data_t, is.numeric))]
  # Error in colMeans(x, na.rm = TRUE) : 'x' must be numeric
  
  library(tidyverse) 
  #test <- gtx_colon_data_t[c(1:2),c(1:2)]
  
  #test_n <- test %>% mutate_if(is.character, is.numeric)
  #test_n[] <- lapply(test, as.numeric)
  # Looks like the values are chars
  
  gtx_data_t_pc <- prcomp(gtx_data_t)
  summary(gtx_data_t_pc)
  
  # REF: https://tavareshugo.github.io/data-carpentry-rnaseq/03_rnaseq_pca.html#Exploring_correlation_between_genes_and_PCs
  pc_loadings <- gtx_data_t_pc$rotation
  
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
    slice(1:top_k) %>% 
    # pull the gene column as a vector
    pull(gene) %>% 
    # ensure only unique genes are retained
    unique()
  
  return(top_genes)
}

# > install.packages("Dict")
#library(Dict)
library(Dict)
top_k_genes <- dict()
#top_k_genes <- hash()

tissue_files = list("gene_tpm_2017-06-05_v8_colon_sigmoid.gct",
                    "gene_tpm_2017-06-05_v8_adipose_subcutaneous.gct",
                    "gene_tpm_2017-06-05_v8_bladder.gct",
                    "gene_tpm_2017-06-05_v8_brain_cortex.gct",
                    "gene_tpm_2017-06-05_v8_breast_mammary_tissue.gct",
                    "gene_tpm_2017-06-05_v8_cervix_endocervix.gct",
                    "gene_tpm_2017-06-05_v8_esophagus_mucosa.gct",
                    "gene_tpm_2017-06-05_v8_kidney_cortex.gct",
                    "gene_tpm_2017-06-05_v8_liver.gct",
                    "gene_tpm_2017-06-05_v8_adrenal_gland.gct",
                    "gene_tpm_2017-06-05_v8_brain_amygdala.gct",
                    "gene_tpm_2017-06-05_v8_fallopian_tube.gct",
                    "gene_tpm_2017-06-05_v8_lung.gct",
                    "gene_tpm_2017-06-05_v8_ovary.gct",
                    "gene_tpm_2017-06-05_v8_pancreas.gct",
                    "gene_tpm_2017-06-05_v8_pituitary.gct",
                    "gene_tpm_2017-06-05_v8_prostate.gct",
                    "gene_tpm_2017-06-05_v8_stomach.gct",
                    "gene_tpm_2017-06-05_v8_thyroid.gct",
                    "gene_tpm_2017-06-05_v8_uterus.gct")

# tissue_files = list("gene_tpm_2017-06-05_v8_colon_sigmoid.gct", 
#                     "gene_tpm_2017-06-05_v8_adipose_subcutaneous.gct",
#                     "gene_tpm_2017-06-05_v8_bladder.gct")

for (tissue_file in tissue_files) {
  print(tissue_file)
  
  top_k = get_top_k_genes(tissue_file, 10)
  print(top_k)
#  top_k_genes[[tissue_file]] = top_k
}

#print(top_k_genes)

