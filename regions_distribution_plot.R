library(ChIPseeker)
library("optparse")
library(TxDb.Mmusculus.UCSC.mm10.knownGene)

txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene
ChIPseeker.downstreamDistance = 2000
promoter_upstream=2000
promoter_downstream=2000


option_list = list(
  make_option(c("-f", "--bed_files"),type="character", default=NULL, 
              help="comma separated list of BED files", metavar="character"),
  make_option(c("-n", "--names"), type="character", default=NULL, 
              help="comma separated list of dataset names", metavar="character"),
  make_option(c("-g", "--genome"), type="character", default="mm10", 
              help="genome version, it can be hg19, hg38, mm9 or mm10. [default= %default]", metavar="character"),
  make_option(c("-o", "--out"), type="character", default="out.pdf", 
              help="output file name [default= %default]", metavar="character")
); 



names=strsplit(option_list$names,',')
bed_files=strsplit(option_list$bed_files,',')
output_file=option_list$out
genome=option_list$genome

# It loads the selected genome
switch(genome,
       mm10={
         library(TxDb.Mmusculus.UCSC.mm10.knownGene);
         txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene;
         anotationDb="org.Mm.eg.db";},
       mm9={
         library(TxDb.Mmusculus.UCSC.mm9.knownGene);
         txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene;
         anotationDb="org.Mm.eg.db";},
       hg38={
         library(TxDb.Hsapiens.UCSC.hg38.knownGene);
         txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene;
         anotationDb="org.Hs.eg.db";},
       hg19={
         library(TxDb.Hsapiens.UCSC.hg19.knownGene);
         txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene;
         anotationDb="org.Hs.eg.db";},
       )

# Annotate the bed files
mylist=lapply(bed_files,
              annotatePeak,tssRegion = c(-promoter_upstream,promoter_downstream),TxDb=txdb,annoDb=anotationDb)

# If the number of provided names is equal to the number of files the names will replace the file names in the plot
if(length(names)==length(bed_files)){
  names(mylist)=names
}

pdf(option_list$out)
plotAnnoBar(mylist)
dev.off()
