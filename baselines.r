# Plot supervised baseline learning curves for all phenotypes

cd <- read.table("/Users/Dima/Boston/Out/cd.txt")
uc <- read.table("/Users/Dima/Boston/Out/uc.txt")
ms <- read.table("/Users/Dima/Boston/Out/ms.txt")
t2d <- read.table("/Users/Dima/Boston/Out/t2d.txt")

ymin <- min(cd$V2, uc$V2, ms$V2, t2d$V2)
ymax <- max(cd$V2, uc$V2, ms$V2, t2d$V2)

pdf("/Users/Dima/Boston/Out/baselines.pdf")

plot(cd$V1, 
     cd$V2,
     ylim=c(ymin, ymax),
     xlab="Training set size",
     ylab="Classification accuracy",
     yaxt="n", 
     type="l", 
     col="blue")

axis(2, las=2) 

lines(uc$V1, uc$V2, col="green")
lines(ms$V1, ms$V2, col="cyan")
lines(t2d$V1, t2d$V2, col="purple")

legend("bottomright", 
       c("CD", "UC", "MS", "T2D"),
       fill=c("blue", "green", "cyan", "purple"))

dev.off()
