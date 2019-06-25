# Bed distribution plot
This script creates a barplot with the feature distribution over genomic regions. 
It uses ChIPSeeker R package

# Installation
```
conda create --name distribution_plot r bioconductor-chipseeker r-optparse bioconductor-TxDb.Mmusculus.UCSC.mm10.knownGene bioconductor-TxDb.Mmusculus.UCSC.mm9.knownGene bioconductor-TxDb.Hsapiens.UCSC.hg19.knownGene bioconductor-TxDb.Hsapiens.UCSC.hg38.knownGene
```
# Run example
```
conda activate distribution_plot
Rscript regions_distribution_plot.R -f file_1.bed,file_2.bed -n my_data_set_1,my_data_set_2 -g mm10 -o myoutput.pdf
conda deactivate
```
