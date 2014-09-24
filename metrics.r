# generate plots for multiple phenotypes
all.phenotypes <- function() {

  phenotypes <- c("cd", "uc", "ms", "t2d")
  cat(sprintf("%3s %5s %5s %5s\n", "", "500", "1000", "3000"))
  for(phenotype in phenotypes) {
    calc.metric(phenotype)
  }
}

# calculate percent of points above baseline curve
# column1: training set sizes
# column2: supervised performance (0 unlabeled examples)
# column4: performance with 500 unlabeled examples
# column6: performance with 1000 unlabeled examples
# column8: performance with 3000 unlabeled examples
calc.metric <- function(phenotype) {

  base <- "/Users/Dima/Boston/Out/"
  file <- paste(base, phenotype, ".txt", sep="")
  out <- paste(base, phenotype, ".pdf", sep="")
  data <- read.table(file)

  dif500 <- data$V4 - data$V2
  dif1000 <- data$V6 - data$V2
  dif3000 <- data$V8 - data$V2

  rat500 <- length(dif500[dif500 > 0]) / length(data$V2)
  rat1000 <- length(dif1000[dif1000 > 0]) / length(data$V2)
  rat3000 <- length(dif3000[dif3000 > 0]) / length(data$V2)

  out <- sprintf("%3s %.3f %.3f %.3f\n", phenotype, rat500, rat1000, rat3000)
  cat(out)
}

# run calculations for all datasets
all.phenotypes()
