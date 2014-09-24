# generate plots for multiple phenotypes
make.plots <- function() {

  phenotypes <- c("cd", "uc", "ms", "t2d")
  for(phenotype in phenotypes) {
    make.plot(phenotype)
  }
}

# generate a plot for a single phenotype (e.g. "cd")
# column1: training set sizes
# column2: supervised performance (0 unlabeled examples)
# column4: performance with 500 unlabeled examples
# column6: performance with 1000 unlabeled examples
# column8: performance with 3000 unlabeled examples
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

# run make.plots function
make.plots()
