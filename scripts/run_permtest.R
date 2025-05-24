#!/usr/bin/env Rscript

suppressMessages(library(GenomicRanges))
suppressMessages(library(regioneR))
suppressMessages(library(GenomicFeatures))
# get arguments from the command line
args <- commandArgs(trailingOnly = TRUE)

# how to run script...
if (length(args) < 3) {
  stop("Command: ./run_permtest.R <background.csv> <foreground.csv> <GQ.bed> <annotation.gtf.gz>")
}

background_file <- args[1]
foreground_file <- args[2]
gq_file <- args[3]
gtf_file <- args[4]

cat("Data loading...\n")
background <- read.csv(background_file)
foreground <- read.csv(foreground_file)
gq <- read.delim(gq_file, header = TRUE, stringsAsFactors = FALSE)

cat("Create GRanges...\n")
background_gr <- GRanges(
  seqnames = background$chromosome,
  ranges = IRanges(start = background$start, end = background$end),
  gene_name = background$gene_name
)

foreground_gr <- GRanges(
  seqnames = foreground$seqnames,
  ranges = IRanges(start = foreground$start, end = foreground$end),
  gene_name = foreground$gene_name
)

# create promoters for the annotation file (for example, -2000 to +1000)
cat("Сreate promoters for the annotation file GTF...\n")
txdb <- makeTxDbFromGFF(gtf_file, format = "gtf")
promoters_all <- promoters(txdb, upstream = 2000, downstream = 1000)


cat("Find intersections...\n")
background_with_proms <- findOverlaps(background_gr, promoters_all)
intersected_proms_with_background <- promoters_all[as.data.frame(background_with_proms)$subjectHits]

foreground_with_proms <- findOverlaps(foreground_gr, promoters_all)
intersected_proms_with_foreground <- promoters_all[as.data.frame(foreground_with_proms)$subjectHits]


cat("Start permutation test...\n")
pt_proms_ <- permTest(
  A = intersected_proms_with_foreground,
  B = gq,
  randomize.function = resampleRegions,
  evaluate.function = numOverlaps,
  universe = intersected_proms_with_background,
  ntimes = 100,
  verbose = TRUE,
  alternative = "auto"
)
# define output picture paramteters
output_file <- "Z_DNA:All_NonTF_genes_vs_NonTF_genes_not_overlap_with_polycomb(control).png"
png(output_file, width = 900, height = 700, res = 120)
plot(pt_proms_)
mtext("ZDNA:All_NonTF_genes_vs_NonTF_genes_not_overlap_with_polycomb.png", side = 3, line = -1, cex = 0.8)
dev.off()

cat(paste0("Done. Result saved in ", output_file, "\n"))
