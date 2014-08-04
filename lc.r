data <- read.table("/Users/Dima/Boston/Out/cd.txt")

ymin <- min(data$V2, data$V4, data$V6, data$V8)
ymax <- max(data$V2, data$V4, data$V6, data$V8)

# yaxt: suppress y axis (to be created manually below)
# type: line vs. dots etc.
plot(data$V1, 
     data$V2,
     xlab="Training set size",
     ylab="Classification accuracy",
     ylim=c(ymin, ymax),
     yaxt="n", 
     type="l", 
     col="blue")

# label orientation for y axis
axis(2, las=2) 

lines(data$V1, data$V4, col="green")
lines(data$V1, data$V6, col="cyan")
lines(data$V1, data$V8, col="purple")

legend("bottomright", 
       c("labeled only", "500", "1000", "3000"),
       fill=c("blue", "green", "cyan", "purple"))
