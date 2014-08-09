# exdata-005
# plot3.R
# 3. Energy sub metering (3 metering variables) by date time line chart

feb1data <- read.table(pipe('grep "^1/2/2007" household_power_consumption.txt'), sep=';', na.strings='?')
feb2data <- read.table(pipe('grep "^2/2/2007" household_power_consumption.txt'), sep=';', na.strings='?')
hdr <- read.table("household_power_consumption.txt", sep=';', nrow=1, header=TRUE)
data <- rbind(na.omit(feb1data),na.omit(feb2data))
colnames(data) <- colnames(hdr)

DateCol <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data <- cbind(data, DateCol)

plot(data$DateCol, data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="", ylim=c(0,30), yaxt = "n")
axis(side = 2, at=seq(0, 30, by=10))
lines(data$DateCol, data$Sub_metering_1, col="black")
lines(data$DateCol, data$Sub_metering_2, col="blue")
lines(data$DateCol, data$Sub_metering_3, col="red")
legend("topright", c("Sub metering 1", "Sub metering 2", "Sub metering 3"), col=c("black", "blue", "red"), pch=20)

dev.copy(png, file="figure/plot3.png", width=480, height=480)
dev.off()
