# generate plots for multiple phenotypes
make.plots <- function() {

  source("/Users/dima/Boston/Git/r/common.r")
  out <- paste(BASE, "all.pdf", sep="")

  pdf(out)
  par(mfrow=c(2,2))

  for(phenotype in c("cd", "uc", "ms", "t2d")) {
    make.plot(phenotype)
  }

  garbage <- dev.off() # disable null device error
}

# generate a plot for a single phenotype (e.g. "cd")
make.plot <- function(phenotype, errorbar = FALSE) {

  data <- load.results(phenotype)
  ymin <- min(data$u0, data$u500, data$u1000, data$u3000)
  ymax <- max(data$u0, data$u500, data$u1000, data$u3000)

  plot(data$size, 
       data$u0,
       ylim=c(ymin, ymax),
       yaxt="n", 
       type="l",
       col="blue",
       xlab="",
       ylab="",
       main=toupper(phenotype))

  if(errorbar) {
    width = 1
    segments(data$size, data$u0-data$v0, data$size, data$u0+data$v0, col="red")
    segments(data$size-width, data$u0-data$v0, data$size+width, data$u0-data$v0)
    segments(data$size-width, data$u0+data$v0, data$size+width, data$u0+data$v0)
  }
  
  axis(2, las=2) 

  lines(data$size, data$u500, col="darkgreen")
  lines(data$size, data$u1000, col="gold")
  lines(data$size, data$u3000, col="purple")

  legend("bottomright", 
         c("labeled only", "500", "1000", "3000"),
         fill=c("blue", "darkgreen", "gold", "purple"))
}

# run make.plots function
make.plots()
