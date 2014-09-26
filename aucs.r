# generate plots for multiple phenotypes
all.auc <- function() {

  phenotypes <- c("cd", "uc", "ms", "t2d")

  cat(sprintf("%3s %6s %6s %6s\n", "", "500", "1000", "3000"))
  for(phenotype in phenotypes) {
    auc.improvement(phenotype)
  }
}

# calcuate semi-supervised curve auc minus baseline auc
# column1: training set sizes
# column2: supervised performance (0 unlabeled examples)
# column4: performance with 500 unlabeled examples
# column6: performance with 1000 unlabeled examples
# column8: performance with 3000 unlabeled examples
auc.improvement <- function(phenotype) {

  require(pracma, quietly=TRUE)
  
  base <- "/Users/Dima/Boston/Out/"
  file <- paste(base, phenotype, ".txt", sep="")
  out <- paste(base, phenotype, ".pdf", sep="")
  data <- read.table(file)

  auc0 <- trapz(data$V1, data$V2)
  auc500 <- trapz(data$V1, data$V4)
  auc1000 <- trapz(data$V1, data$V6)
  auc3000 <- trapz(data$V1, data$V8)

  dif500 <- auc500 - auc0
  dif1000 <- auc1000 - auc0
  dif3000 <- auc3000 - auc0
  
  out <- sprintf("%3s %6.3f %6.3f %6.3f\n", phenotype, dif500, dif1000, dif3000)
  cat(out)
}

# run make.plots function
all.auc()
