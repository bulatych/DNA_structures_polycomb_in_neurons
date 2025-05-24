**The role of secondary DNA structures in neuron-specific regulation by Polycomb repressive complexes (PRC)**
> **Rakhimov Bulat** HSE University  
> tg: @bulatych_7  
> brrakhimov@hse.edu.ru  

This repository contains the results of the semester project at the Bioinformatics Institute

**Supervisor**: Maria Poptsova, Ekaterina Khrameeva

**Objective**

The 3D genome organization in human neurons differs significantly from other cell types. A hallmark feature is the presence of long-range interactions called “neuronal dots,” visible on Hi-C maps and overlapping with H3K27me3 ChIP-seq peaks linked to Polycomb-mediated repression [Pletenev 2024](https://academic.oup.com/nar/article/52/11/6234/7655789?login=false). It has been experimentally demonstrated that PRC2 complex components associate with G-quadruplex structures, and that there is specific binding of the CTCF protein to G-quadruplexes [Hemphill et al.](https://pmc.ncbi.nlm.nih.gov/articles/PMC10266057/). 
This study explores the localization of Z-DNA and G-quadruplexes at PRC2 anchor regions in neurons.

Picture

**Goals**

1. Investigate the localization of G-quadruplexes(G4s) and Z-DNA at PRC2 anchor regions in human neurons. Examine the enrichment of these secondary DNA structures in promoter regions  of both transcription factor (TF) and non-transcription factor (non-TF) genes of polycomb anchor regions.

2. Perform gene ontology analysis to link the identified regions to relevant biological processes. Examine tissue-specifity for genes with Z-DNA and G4s.

3. Utilize UMAP clustering to explore how experimental and predicted Z-DNA regions group and are characterized by various omics features in neuronal tissue. Higlight the clustering patterns of Z-DNA regions that overlap with PRC2 anchors.


**Results**

1. Significant enrichment of Z-DNA and G-quadruplexes was observed at PRC2 anchor regions in neurons, particularly within the promoter regions of both TF and non-TF genes.

<div align="center">
  <table>
    <tr>
      <td>
        <img src="./imgs/Permutation%20test/Z-DNA:All_TF_genes_vs_TF_genes_in_polycomb.png" alt="TF_Z-DNA" width="450"/>
      </td>
      <td>
        <img src="./imgs/Permutation%20test/GQ:All_TF_genes_vs_TF_genes_in_polycomb.png" alt="TF_GQ" width="450"/>
      </td>
    </tr>
    <tr>
      <td colspan="2" align="center">
        Fig. 1. Permutation test for Z-DNA and G4s regions in transcription factor genes overlapping with Polycomb anchor regions.
      </td>
    </tr>
  </table>
</div>


2. Gene ontology analysis revealed strong associations of these loci with neuronal development, chromatin remodeling, and transcriptional repression pathways. Tissue enrichment analysis confirmed that some genes are highly expressed in the brain, as well as in other tissues.


![GO Analysis_GQ](./imgs/Gene%20ontology/GO_combined_GQ_TF_genes.png)

<div align="center">
  <table border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td colspan="2" align="center">
        <img src="./imgs/Gene%20ontology/Z-DNA-NonTF_genes_GO:BP.png" alt="GO ZDNA BP" width="450"/>
      </td>
    </tr>
    <tr>
      <td>
        <img src="./imgs/Gene%20ontology/Z-DNA-NonTF_genes_GO:MF.png" alt="GO ZDNA MF" width="350"/>
      </td>
      <td>
        <img src="./imgs/Gene%20ontology/Z-DNA-NonTF_genes_GO:CC.png" alt="GO ZDNA CC" width="350"/>
      </td>
    </tr>
    <tr>
      <td colspan="2" align="center">
        <b>Figure:</b> Gene ontology enrichment analysis (BP, MF, CC) for non-transcription factor genes with Z-DNA structures in PRC2 regions.
      </td>
    </tr>
  </table>
</div>



3. UMAP clustering revealed that Z-DNA regions exhibit distinct patterns when characterized by omics features in neuronal tissue. This clustering highlighted key signals, including transcription factors, histone marks, RNA Polymerase II and III binding sites, and DNase I hypersensitivity sites.
Z-DNA regions overlapping with PRC2 anchors exhibited a similar clustering pattern to other regions.

![UMAP_Z-DNA_leiden](./imgs/UMAP/exp_and_predicted_zdna_chip_atlas_omics_n200_res0.25.png)

![UMAP_Z-DNA](./imgs/UMAP/filter_row_95_umap_n55_d0.1_mmanhattan.png)


**Conclusion**

 Our findings suggest that secondary DNA structures such as Z-DNA and G-quadruplexes are enriched at PRC2 anchor regions in human neurons and may play a role in Polycomb-mediated gene regulation. Their association with key regulatory features and neuronal gene expression points to a potential involvement in shaping the unique chromatin landscape of neuronal cells.



**Contents**

All results are available in the `imgs` directory. Scripts and notebooks for overlap analysis, permutation testing, and GO enrichment are located in the `scripts` and `notebooks` directories, respectively. The defined DNA regions overlapping with polycomb anchors can be found in the `intersections` folder. The UMAP clustering is shown in `UMAP.ipynb`.

**Raw data**

- `HG38_ZDNA_ZDNABERT_predictions_thr_0.25_minlen_6.bed` - predicted regions of Z-DNA with ZDNABERT

- `HG38_GQ_predictions_thr_0.25_minlen_6.bed`, - predicted regions of G-quadruplexes based on [Endoquad](https://academic.oup.com/nar/article/52/D1/D72/7334091) database with strand

- `polycomb_dot_anchors.bed` - Polycomb anchor regions with genes, identifying long-range interactions characteristic of neuronal dots.

- `gencode.v47.chr_patch_hapl_scaff.basic.annotation.gtf.gz` - Gene annotation file GENCODE v47 of GRCh38 assembly

- `Experiment_and_predicted_z_dna_ Neural_omics` - A matrix of overlapping Z-DNA regions with neural omics data (transcription factor binding, histone marks, RNA Polymerase II/III binding sites, DNase hypersensitive sites)
- `All_nonTF_genes_GRCh38.csv`; `All_TF_genes_GRCh38.csv` - All TF and nonTF genes for GRCh38


Extracted transcription factor (TF) and non-transcription factor (non-TF) genes that are present in polycomb regions and contain Z-DNA or G-quadruplexes can be found in `TF_and_not_TF_genes` folder

The **omics data** is too large to keep in GitHub.

It can be downloaded from [Chip-atlas](https://chip-atlas.org/) using the custom Python notebook `Example.ipynb`, created by the [HSE Bioinformatics Lab](https://github.com/hse-bioinflab/OmicsDC).

**References** 
- [Pletenev IA et al.(2024). Extensive long-range polycomb interactions and weak compartmentalization are hallmarks of human neuronal 3D genome. _Nucleic acids research_, 52(11), 6234–6252.](https://academic.oup.com/nar/article/52/11/6234/7655789?login=false)
- [Hemphill WO et al.(2023). PRC2 direct transfer from G-quadruplex RNA to dsDNA has implications for RNA-binding chromatin modifiers. _Proceedings of the National Academy of Sciences of the United States of America_, 120(23), e2220528120.](https://pmc.ncbi.nlm.nih.gov/articles/PMC10266057/)
- [Beknazarov N, Jin S & Poptsova M (2020). Deep learning approach for predicting functional Z-DNA regions using omics data. _Scientific reports_, 10(1), 19134.](https://pubmed.ncbi.nlm.nih.gov/33154517/)
- [Beknazarov N et al.(2024). Z-DNA formation in promoters conserved between human and mouse are associated with increased transcription reinitiation rates. _Sci Rep_, 14, 17786.](https://www.nature.com/articles/s41598-024-68439-y)
- [Sheng Hu Qian et al. (2024). EndoQuad: a comprehensive genome-wide experimentally validated endogenous G-quadruplex database, _Nucleic Acids Research_, 52(D1), D72–D80.](https://academic.oup.com/nar/article/52/D1/D72/7334091#434768924)
- [Zhaonan Zou et al. (2024). ChIP-Atlas 3.0: a data-mining suite to explore chromosome architecture together with large-scale regulome data, _Nucleic Acids Research_, 52(W1), W45–W53.](https://academic.oup.com/nar/article/52/W1/W45/7671323)