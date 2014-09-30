# generate plots for multiple phenotypes
make.plots <- function() {

  phenotypes <- c("cd", "uc", "ms", "t2d")
  for(phenotype in phenotypes) {
    make.plot(phenotype)
  }
}

# generate a plot for a single phenotype (e.g. "cd")
make.plot <- function(phenotype) {

  source("common.r")
  data <- load.results(phenotype)

  ymin <- min(data$u0, data$u500, data$u1000, data$u3000)
  ymax <- max(data$u0, data$u500, data$u1000, data$u3000)

  out <- paste(BASE, phenotype, ".pdf", sep="")
  pdf(out)

  plot(data$size, 
       data$u0,
       xlab="Training set size",
       ylab="Classification accuracy",
       ylim=c(ymin, ymax),
       yaxt="n", 
       type="l", 
       col="blue")

  axis(2, las=2) 

  lines(data$size, data$u500, col="green")
  lines(data$size, data$u1000, col="cyan")
  lines(data$size, data$u3000, col="purple")

  legend("bottomright", 
         c("labeled only", "500", "1000", "3000"),
         fill=c("blue", "green", "cyan", "purple"))

  dev.off()
}

# run make.plots function
make.plots()
