library(dplyr)
library(readr)
library(stringr)
library(data.table)
library(rtracklayer)
library(rstudioapi)
library(tidyr)

## This Rscript will help to devide genes in founded intersections on TF and nonTF genes

main_dir <- dirname(getSourceEditorContext()$path) 
setwd(main_dir)

intersections_file <- "../data/intersections/G4_in_polycomb_ignore_strand.csv" # or Z-DNA_in_polycomb.csv
intersections <- read_csv(intersections_file)
polycomb_file <- "../data/polycomb_dot_anchors.bed"
polycomb <- fread(polycomb_file, header = FALSE, col.names = c("chr", "start", "end", "gene_name"))
tf_genes_file <- "../data/TF_and_not_TF_genes/All_TF_genes_GRCh38.csv"
tf_genes <- read_csv(tf_genes_file)

gtf_file <- "../data/gencode.v47.chr_patch_hapl_scaff.basic.annotation.gtf.gz"
gtf <- import(gtf_file)
genes_gtf <- as.data.frame(gtf) %>% filter(type == "gene")

genes_from_secondary <- unique(intersections$gene_name)

# Filtering of annotated genes by intersections
annotated_genes <- genes_gtf %>%
  filter(gene_name %in% genes_from_secondary) %>%
  select(seqnames, start, end, strand, gene_id, gene_name)

# TF / non-TF label
annotated_genes <- annotated_genes %>%
  mutate(TF_class = ifelse(gene_name %in% tf_genes$gene_name, "TF", "non-TF"))

tf_genes_in_intersections <- annotated_genes %>%
  filter(TF_class == "TF")

non_tf_genes_in_intersections <- annotated_genes %>%
  filter(TF_class == "non-TF")

write_csv(tf_genes_in_intersections, "G4_polycomb_TF_genes.csv")
write_csv(non_tf_genes_in_intersections, "G4_polycomb_nonTF_genes.csv")


