#loading and downsampling data
datasets <- c("adipose_visceral_omentum.gct", "adrenal_gland.gct", "artery_aorta.gct", "artery_coronary.gct", "artery_tibial.gct", "bladder.gct", "brain_amygdala.gct", "brain_anterior_cingulate_cortex_ba24.gct", "brain_caudate_basal_ganglia.gct", "brain_cerebellar_hemisphere.gct", "brain_cerebellum.gct", "brain_cortex.gct", "brain_frontal_cortex_ba9.gct", "brain_hippocampus.gct", "brain_hypothalamus.gct", "brain_nucleus_accumbens_basal_ganglia.gct", "brain_putamen_basal_ganglia.gct", "brain_spinal_cord_cervical_c_1.gct", "brain_substantia_nigra.gct", "breast_mammary_tissue.gct", "cells_cultured_fibroblasts.gct", "cells_ebv_transformed_lymphocytes.gct", "cervix_ectocervix.gct", "cervix_endocervix.gct", "colon_sigmoid.gct", "colon_transverse.gct", "esophagus_gastroesophageal_junction.gct", "esophagus_mucosa.gct", "esophagus_muscularis.gct", "fallopian_tube.gct", "heart_atrial_appendage.gct", "heart_left_ventricle.gct", "kidney_cortex.gct", "kidney_medulla.gct", "liver.gct", "lung.gct", "minor_salivary_gland.gct", "muscle_skeletal.gct", "nerve_tibial.gct", "ovary.gct", "pancreas.gct", "pituitary.gct", "prostate.gct", "skin_not_sun_exposed_suprapubic.gct", "skin_sun_exposed_lower_leg.gct", "small_intestine_terminal_ileum.gct", "spleen.gct", "stomach.gct", "testis.gct", "thyroid.gct", "uterus.gct", "vagina.gct", "whole_blood.gct")

for (d in datasets) {
  read.command <- paste(" <- data.frame(fread(\"/Users/pigsnsheep/Documents/GitHub/pigsnsheep.github.io/gtex_project/" , d , "\", select = c(2,4)))", sep = "")
  text1 = paste(d, read.command, sep = "")
  text2 = paste("rownames(", d, ") <- ", d, "$Name", sep = "")
  text3 = paste(d, " <- select(", d, ",-Name)", sep = "")
  eval(parse(text = text1))
  eval(parse(text = text2))
  eval(parse(text = text3))
}

#Binding all datasets into "everything"
datasets2 <- c("artery_aorta.gct", "artery_coronary.gct", "artery_tibial.gct", "bladder.gct", "brain_amygdala.gct", "brain_anterior_cingulate_cortex_ba24.gct", "brain_caudate_basal_ganglia.gct", "brain_cerebellar_hemisphere.gct", "brain_cerebellum.gct", "brain_cortex.gct", "brain_frontal_cortex_ba9.gct", "brain_hippocampus.gct", "brain_hypothalamus.gct", "brain_nucleus_accumbens_basal_ganglia.gct", "brain_putamen_basal_ganglia.gct", "brain_spinal_cord_cervical_c_1.gct", "brain_substantia_nigra.gct", "breast_mammary_tissue.gct", "cells_cultured_fibroblasts.gct", "cells_ebv_transformed_lymphocytes.gct", "cervix_ectocervix.gct", "cervix_endocervix.gct", "colon_sigmoid.gct", "colon_transverse.gct", "esophagus_gastroesophageal_junction.gct", "esophagus_mucosa.gct", "esophagus_muscularis.gct", "fallopian_tube.gct", "heart_atrial_appendage.gct", "heart_left_ventricle.gct", "kidney_cortex.gct", "kidney_medulla.gct", "liver.gct", "lung.gct", "minor_salivary_gland.gct", "muscle_skeletal.gct", "nerve_tibial.gct", "ovary.gct", "pancreas.gct", "pituitary.gct", "prostate.gct", "skin_not_sun_exposed_suprapubic.gct", "skin_sun_exposed_lower_leg.gct", "small_intestine_terminal_ileum.gct", "spleen.gct", "stomach.gct", "testis.gct", "thyroid.gct", "uterus.gct", "vagina.gct", "whole_blood.gct")
everything <- cbind(adrenal_gland.gct, adipose_visceral_omentum.gct)
for (d in datasets2){
  text1 = paste("everything <- cbind(everything, ", d, ")", sep = "")
  eval(parse(text = text1))
}
write.csv(everything, "all_tissues.csv")


true.data <- read.table("../../../Combined.gct", skip = 3)

max(true.data.means)

true.data.means <- data.frame(rowMeans(true.data.numeric))

ggplot(true.data.means, aes(x=log10(x))) + geom_histogram()

colnames(true.data.means) <- c("x")

true.data.labels <- true.data[,c(1,2)]
true.data.numeric <- true.data[,-c(1,2)]

true.data.numeric.means <- na.omit(true.data.numeric.means)
