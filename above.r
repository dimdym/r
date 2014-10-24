# generate plots for multiple phenotypes
all.phenotypes <- function(directory) {

  cat(sprintf("%3s %7s %7s %7s\n", "", "500", "1000", "3000"))

  total_above <- 0
  for(phenotype in c("cd", "uc", "ms", "t2d")) {
    phenotype_above <- above.baseline(directory, phenotype)
    total_above <- total_above + phenotype_above
  }

  cat(sprintf("%3s %7.2f\n", "av", (total_above * 100) / 12))
}

# calculate percent of points above baseline curve
above.baseline <- function(directory, phenotype) {

    # look at training set sizes up to this
  MAXSIZE = 100
  
  file <- paste(phenotype, ".txt", sep="")
  data <- load.results(file.path(directory, file))
  data.subset <- data[data$size <= MAXSIZE, ]

  dif500 <- data.subset$u500 - data.subset$u0
  dif1000 <- data.subset$u1000 - data.subset$u0
  dif3000 <- data.subset$u3000 - data.subset$u0

  rat500 <- length(dif500[dif500 > 0]) / length(data.subset$u0)
  rat1000 <- length(dif1000[dif1000 > 0]) / length(data.subset$u0)
  rat3000 <- length(dif3000[dif3000 > 0]) / length(data.subset$u0)

  out <- sprintf("%3s %7.2f %7.2f %7.2f\n", phenotype,
                 rat500 * 100, rat1000 * 100, rat3000 * 100)
  cat(out)
  
  return(rat500 + rat1000 + rat3000)
}

# main method
source("common.r")
for(experiment.directory in list.files(RESULTROOT)) {
  cat(sprintf("* %s\n\n", experiment.directory))
  all.phenotypes(file.path(RESULTROOT, experiment.directory))
  cat("\n")
}
