# exdata-005
# plot1.R
# 2. Global active power by date-time line chart

feb1data <- read.table(pipe('grep "^1/2/2007" household_power_consumption.txt'), sep=';', na.strings='?')
feb2data <- read.table(pipe('grep "^2/2/2007" household_power_consumption.txt'), sep=';', na.strings='?')
hdr <- read.table("household_power_consumption.txt", sep=';', nrow=1, header=TRUE)
data <- rbind(na.omit(feb1data),na.omit(feb2data))
colnames(data) <- colnames(hdr)

DateCol <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data <- cbind(data, DateCol)

plot(data$DateCol, data$Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab="")
lines(data$DateCol, data$Global_active_power, )

dev.copy(png, file="figure/plot2.png", width=480, height=480)
dev.off()
