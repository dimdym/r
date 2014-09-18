# generate plots for multiple phenotypes
make.plots <- function() {

  phenotypes <- c("cd", "uc", "ms", "t2d")

  cat(sprintf("%3s %5s %5s %5s\n", "", "500", "1000", "3000"))
  for(phenotype in phenotypes) {
    make.plot(phenotype)
    auc.improvement(phenotype)
  }
}

# generate a plot for a single phenotype (e.g. "cd")
# column1: training set sizes
# column2: supervised performance (0 unlabeled examples)
# column4: performance with 500 unlabeled examples
# column6: performance with 1000 unlabeled examples
# column8: performance with 5000 unlabeled examples
make.plot <- function(phenotype) {

  base <- "/Users/Dima/Boston/Out/"
  file <- paste(base, phenotype, ".txt", sep="")
  out <- paste(base, phenotype, ".pdf", sep="")
  data <- read.table(file)

  ymin <- min(data$V2, data$V4, data$V6, data$V8)
  ymax <- max(data$V2, data$V4, data$V6, data$V8)

  pdf(out)

  plot(data$V1, 
       data$V2,
       xlab="Training set size",
       ylab="Classification accuracy",
       ylim=c(ymin, ymax),
       yaxt="n", 
       type="l", 
       col="blue")

  axis(2, las=2) 

  lines(data$V1, data$V4, col="green")
  lines(data$V1, data$V6, col="cyan")
  lines(data$V1, data$V8, col="purple")

  legend("bottomright", 
         c("labeled only", "500", "1000", "3000"),
         fill=c("blue", "green", "cyan", "purple"))

  dev.off()
}

# calcuate semi-supervised curve auc minus baseline auc
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
  
  out <- sprintf("%3s %.3f %.3f %.3f\n", phenotype, dif500, dif1000, dif3000)
  cat(out)
}

# run make.plots function
make.plots()
