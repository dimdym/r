# generate plots for phenotypes in a directory
all.auc <- function(directory) {

  cat(sprintf("%3s %7s %7s %7s\n", "", "500", "1000", "3000"))

  total_auc <- 0
  for(phenotype in c("cd", "uc", "ms", "t2d")) {
    phenotype_auc <- auc.improvement(directory, phenotype)
    total_auc <- total_auc + phenotype_auc
  }

  cat(sprintf("%3s %7.3f\n", "av", total_auc / 12))
}

# calcuate semi-supervised curve auc minus baseline auc
auc.improvement <- function(directory, phenotype) {

  file <- paste(phenotype, ".txt", sep="")
  data <- load.results(file.path(directory, file))

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

# main method
source('/Users/Dima/Boston/Git/R/common.r')
for(experiment_directory in list.files(RESULTROOT)) {
  cat(sprintf("\n* %s\n\n", experiment_directory))
  all.auc(file.path(RESULTROOT, experiment_directory))
}
