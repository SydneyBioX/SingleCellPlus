# List the library paths
# The issue is likely to be in the first directory
paths = .libPaths()

## Try and detect bad files
list.files(paths, 
           pattern = "^00LOCK*|*\\.rds$|*\\.RDS$",
           full.names = TRUE)

## List files of size 0
l = list.files(paths, full.names = TRUE)
l[sapply(l, file.size) == 0]

###############################################

if ("BiocManager" %in% rownames(installed.packages()))
	remove.packages("BiocManager")

install.packages("BiocManager", repos="https://cran.rstudio.com")
#install.packages("devtools", repos="https://cran.rstudio.com")
#devtools::install_github("Bioconductor/BiocManager")
library(BiocManager)

if(BiocManager::version() != "3.10"){
    BiocManager::install(version="3.10",
                         update=TRUE, ask=FALSE)
}

builtins <- c(
	"scMerge", "devtools", 
	"DropletUtils", "edgeR",
	"ggpubr", "MAST", 
	"plyr", "Rtsne", 
	"scales", "scater", 
	"scran", "tidyverse", 
	"viridis", "monocle", 
	"kevinwang09/scdney")

for (builtin in builtins)
    if (!suppressWarnings(require(builtin, character.only=TRUE)))
        suppressWarnings(BiocManager::install(builtin,
                                              version="3.10",
                                              update=FALSE, ask=FALSE))