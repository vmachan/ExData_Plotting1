# exdata-005
# plot4.R
# 4. 4 charts (order by mfrow below)
#    1. Global active power by time (top-left)
#    2. Voltage by datetime (top-right)
#    3. Energy sub metering by time (bottom-left)
#    4. Global reactive power by time (bottom-right)

# Read the data in
feb1data <- read.table(pipe('grep "^2/1/2007" household_power_consumption.txt'), sep=';', na.strings='?')
feb2data <- read.table(pipe('grep "^2/2/2007" household_power_consumption.txt'), sep=';', na.strings='?')
hdr <- read.table("household_power_consumption.txt", sep=';', nrow=1, header=TRUE)
data <- rbind(na.omit(feb1data),na.omit(feb2data))
colnames(data) <- colnames(hdr)

# Do the date time conversion
DateCol <- as.POSIXct(paste(data$Date, data$Time), format="%m/%d/%Y %H:%M:%S")
data <- cbind(data, DateCol)

# Plot the base plot
par(mfcol = c(2,2))

with (data, {
# Plot the first chart at top-left - Global Active Power by time
plot(data$DateCol, data$Global_active_power, type="n", ylab="Global Active Power", ylim=c(0, 8.0), yaxt = "n", xlab="")
axis(side = 2, at=seq(0.0, 8.0, by=2))
lines(data$DateCol, data$Global_active_power, col="black")

# Plot the second chart at bottom-left - Energy sub metering by time
plot(data$DateCol, data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="", ylim=c(0,30), yaxt = "n")
axis(side = 2, at=seq(0, 30, by=10))
lines(data$DateCol, data$Sub_metering_1, col="black")
lines(data$DateCol, data$Sub_metering_2, col="blue")
lines(data$DateCol, data$Sub_metering_3, col="red")
legend("topright", c("Sub metering 1", "Sub metering 2", "Sub metering 3"), col=c("black", "blue", "red"), pch=20, cex=0.6, bty="n")

# Plot the third chart at top-right - Voltage by time
plot(data$DateCol, data$Voltage, type="n", ylab="Voltage", xlab="datetime", ylim=c(234,246), yaxt = "n")
axis(side = 2, at=seq(234, 246, by=4))
lines(data$DateCol, data$Voltage, col="black")

# Plot the fourth chart at bottom-right - Global reactive power by time
plot(data$DateCol, data$Global_reactive_power, type="n", ylab="Global_reactive_power", xlab="datetime", ylim=c(0, 0.5), yaxt = "n")
axis(side = 2, at=seq(0.0, 0.5, by=0.1))
lines(data$DateCol, data$Global_reactive_power, col="black")
})

# Write the plot to a PNG file
dev.copy(png, file="figure/plot4.png", width=480, height=480)
dev.off()
