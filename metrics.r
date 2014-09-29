# generate plots for multiple phenotypes
all.phenotypes <- function() {

  phenotypes <- c("cd", "uc", "ms", "t2d")
  cat(sprintf("%3s %5s %5s %5s\n", "", "500", "1000", "3000"))
  for(phenotype in phenotypes) {
    calc.metric(phenotype)
  }
}

# calculate percent of points above baseline curve
calc.metric <- function(phenotype) {

  source("common.r")
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

# run calculations for all datasets
all.phenotypes()
