#!/usr/bin/env Rscript

# generate plots for the phenotypes in a directory
make.plot <- function(directory) {

  pdf(file.path(directory, "averaged.pdf"))
  par(mfrow=c(1,1))
  accuracy.plot(directory)
  garbage <- dev.off() # disable null device error
}

# generate plot by averaging accross all phenotypes
accuracy.plot <- function(directory) {

  cd <- load.results(file.path(directory, "cd.txt"))
  uc <- load.results(file.path(directory, "uc.txt"))
  ms <- load.results(file.path(directory, "ms.txt"))
  t2d <- load.results(file.path(directory, "t2d.txt"))

  baseline = (cd$u0 + uc$u0 + ms$u0 + t2d$u0) / 4
  curve500 = (cd$u500 + uc$u500 + ms$u500 + t2d$u500) / 4
  curve1000 = (cd$u1000 + uc$u1000 + ms$u1000 + t2d$u1000) / 4
  curve3000 = (cd$u3000 + uc$u3000 + ms$u3000 + t2d$u3000) / 4
  
  ymin <- min(baseline, curve500, curve1000, curve3000)
  ymax <- max(baseline, curve500, curve1000, curve3000)
  xmax <- max(cd$size)
  
  plot(0, xlim=c(0, xmax), ylim=c(ymin, ymax), yaxt="n", type="n",
       xlab="Number of labeled examples", ylab="Classification accuracy",
       main="Average performance")
  
  axis(2, las=2) 

  lines(cd$size, baseline, col="blue")
  lines(cd$size, curve500, col="darkgreen")
  lines(cd$size, curve1000, col="gold")
  lines(cd$size, curve3000, col="purple")

  # legend("bottomright", 
  #        c("labeled only", "500", "1000", "3000"),
  #        fill=c("blue", "darkgreen", "gold", "purple"))
}

# main method
source('/Users/Dima/Boston/Git/R/common.r')
for(experiment_directory in list.files(RESULTROOT)) {
  make.plot(file.path(RESULTROOT, experiment_directory))
}
