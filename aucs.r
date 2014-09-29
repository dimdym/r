# generate plots for multiple phenotypes
all.auc <- function() {

  phenotypes <- c("cd", "uc", "ms", "t2d")
  cat(sprintf("%3s %7s %7s %7s\n", "", "500", "1000", "3000"))

  total_auc <- 0
  for(phenotype in phenotypes) {
    phenotype_auc <- auc.improvement(phenotype)
    total_auc <- total_auc + phenotype_auc
  }

  cat(sprintf("%3s %7.3f\n", "av", total_auc / 12))
}

# calcuate semi-supervised curve auc minus baseline auc
auc.improvement <- function(phenotype) {

  source("common.r")
  data <- load.results(phenotype)

  require(pracma, quietly=TRUE)
  auc0 <- trapz(data$size, data$u0)
  auc500 <- trapz(data$size, data$u500)
  auc1000 <- trapz(data$size, data$u1000)
  auc3000 <- trapz(data$size, data$u3000)

  dif500 <- auc500 - auc0
  dif1000 <- auc1000 - auc0
  dif3000 <- auc3000 - auc0
  
  out <- sprintf("%3s %7.3f %7.3f %7.3f\n", phenotype, dif500, dif1000, dif3000)
  cat(out)

  return(dif500 + dif1000 + dif3000)
}

# run make.plots function
all.auc()
