#!/usr/bin/env Rscript

# generate plots for the phenotypes in a directory
make.plots <- function(directory) {

  pdf(file.path(directory, "plots.pdf"))
  par(mfrow=c(2,2))

  for(phenotype in c("cd", "uc", "ms", "t2d")) {
    make.plot(directory, phenotype)
  }

  garbage <- dev.off() # disable null device error
}

# generate a plot for a phenotype stored in a directory
make.plot <- function(directory, phenotype, errorbars = FALSE) {

  file <- paste(phenotype, ".txt", sep="")
  data <- load.results(file.path(directory, file))
  ymin <- min(data$u0, data$u500, data$u1000, data$u3000)
  ymax <- max(data$u0, data$u500, data$u1000, data$u3000)
  xmax <- max(data$size)
  
  plot(0, xlim=c(0, xmax), ylim=c(ymin, ymax), yaxt="n", type="n",
       xlab="Number of labeled examples", ylab="Accuracy",
       font.main=1, main=PHENAMES[[phenotype]])
  
  axis(2, las=2) 

  lines(data$size, data$u0, col="blue")
  lines(data$size, data$u500, col="darkgreen")
  lines(data$size, data$u1000, col="gold")
  lines(data$size, data$u3000, col="purple")

  legend("bottomright", 
         c("labeled only", "500", "1000", "3000"),
         fill=c("blue", "darkgreen", "gold", "purple"))
  
  if(errorbars) {
    width = 1
    segments(data$size, data$u0-data$v0, data$size, data$u0+data$v0, col="red")
    segments(data$size-width, data$u0-data$v0, data$size+width, data$u0-data$v0)
    segments(data$size-width, data$u0+data$v0, data$size+width, data$u0+data$v0)
  }
}

# main method
source('/Users/Dima/Boston/Git/R/common.r')
for(experiment_directory in list.files(RESULTROOT)) {
  make.plots(file.path(RESULTROOT, experiment_directory))
}
