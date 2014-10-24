# generate plots for multiple phenotypes
all.phenotypes <- function(directory) {

  cat(sprintf("%3s %7s %7s %7s\n", "", "500", "1000", "3000"))

  total_improvement <- 0
  for(phenotype in c("cd", "uc", "ms", "t2d")) {
    phenotype_improvement <- average.improvement(directory, phenotype)
    total_improvement <- total_improvement + phenotype_improvement
  }

  cat(sprintf("%3s %7.2f\n", "av", total_improvement / 12))
}

# average improvement above baseline
average.improvement <- function(directory, phenotype) {

  # look at training set sizes up to this
  MAXSIZE = 100
  
  file <- paste(phenotype, ".txt", sep="")
  data <- load.results(file.path(directory, file))
  data.subset <- data[data$size <= MAXSIZE, ]
  
  diff500 <- data.subset$u500 - data.subset$u0
  diff1000 <- data.subset$u1000 - data.subset$u0
  diff3000 <- data.subset$u3000 - data.subset$u0

  out <- sprintf("%3s %7.2f %7.2f %7.2f\n", phenotype,
                 mean(diff500), mean(diff1000), mean(diff3000))
  cat(out)

  return(mean(diff500) + mean(diff1000) + mean(diff3000))
}

# calculate percent of points above baseline curve
above.baseline <- function(phenotype) {

  data <- load.results(phenotype)

  dif500 <- data$u500 - data$u0
  dif1000 <- data$u1000 - data$u0
  dif3000 <- data$u3000 - data$u0

  rat500 <- length(dif500[dif500 > 0]) / length(data$u0)
  rat1000 <- length(dif1000[dif1000 > 0]) / length(data$u0)
  rat3000 <- length(dif3000[dif3000 > 0]) / length(data$u0)

  out <- sprintf("%3s %.3f %.3f %.3f\n", phenotype, rat500, rat1000, rat3000)
  cat(out)
}

# main method
source("common.r")
for(experiment.directory in list.files(RESULTROOT)) {
  cat(sprintf("* %s\n\n", experiment.directory))
  all.phenotypes(file.path(RESULTROOT, experiment.directory))
  cat("\n")
}
