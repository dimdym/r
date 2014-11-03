#!/usr/bin/env Rscript

# generate plot by averaging accross all phenotypes
plot.accuracy <- function(folder, title) {

  cd <- load.results(file.path(folder, "cd.txt"))
  uc <- load.results(file.path(folder, "uc.txt"))
  ms <- load.results(file.path(folder, "ms.txt"))
  t2d <- load.results(file.path(folder, "t2d.txt"))

  baseline = (cd$u0 + uc$u0 + ms$u0 + t2d$u0) / 4
  curve500 = (cd$u500 + uc$u500 + ms$u500 + t2d$u500) / 4
  curve1000 = (cd$u1000 + uc$u1000 + ms$u1000 + t2d$u1000) / 4
  curve3000 = (cd$u3000 + uc$u3000 + ms$u3000 + t2d$u3000) / 4
  
  ymin <- min(baseline, curve500, curve1000, curve3000)
  ymax <- max(baseline, curve500, curve1000, curve3000)
  xmax <- max(cd$size)

  titles <- c("1.00" = " = 1.00",
              "0.05" = " = 0.05",
              "0.20" = " = 0.20",
              "0.50" = " = 0.50",
              "Heuristic" = " set by heuristic",
              "Search" = " set by cross-validation")
  caption = titles[[title]]
  
  plot(0, xlim=c(0, xmax), ylim=c(ymin, ymax), yaxt="n", type="n",
       xlab="Number of labeled examples", ylab="Accuracy",
       main=substitute(paste(lambda, caption), list(caption=caption)))
  
  axis(2, las=2) 

  lines(cd$size, curve500, col="darkgreen")
  lines(cd$size, curve1000, col="gold")
  lines(cd$size, curve3000, col="purple")
  lines(cd$size, baseline, col="blue")
  
  legend("bottomright", 
         c("labeled only", "500", "1000", "3000"),
         fill=c("blue", "darkgreen", "gold", "purple"))
}

# main method
source("/Users/Dima/Boston/Git/R/common.r")

pdf("/Users/Dima/Boston/Out/averaged.pdf", width=9, height=6)
par(mfrow=c(2, 3), oma=c(3,0,0,0)) 

for(folder in c("1.00", "Heuristic", "Search", "0.05", "0.20", "0.50")) {
  plot.accuracy(file.path(RESULTROOT, folder), folder)
}

# title(side=1, "Average Learning Curves", outer=TRUE)
mtext(side=1, line=1, "Figure 1. Average Learning Curves.", outer=TRUE) 
garbage <- dev.off() # disable null device error
