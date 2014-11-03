#!/usr/bin/env Rscript

# constants
RESULTROOT = "/Users/dima/Boston/SemSup/Em/Results/"

# mapping to full phenotype names
PHENAMES = list(cd="Crohn\'s Disease", uc="Ulcerative Colitis",
                ms="Multiple Sclerosis", t2d="Type II Diabetes")

# load experimental data for a phenotype
# column1: training set sizes
# column2: supervised performance (0 unlabeled examples)
# column4: performance with 500 unlabeled examples
# column6: performance with 1000 unlabeled examples
# column8: performance with 3000 unlabeled examples
load.results <- function(file) {
  data <- read.table(file)
  names <- c("size", "u0", "v0", "u500", "v500", "u1000", "v1000", "u3000", "v3000")
  colnames(data) <- names
  return(data)
}
