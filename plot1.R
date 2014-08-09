# exdata-005
# plot1.R
# 1. Global active power plot histogram

feb1data <- read.table(pipe('grep "^2/1/2007" household_power_consumption.txt'), sep=';', na.strings='?')
feb2data <- read.table(pipe('grep "^2/2/2007" household_power_consumption.txt'), sep=';', na.strings='?')
hdr <- read.table("household_power_consumption.txt", sep=';', nrow=1, header=TRUE)
data <- rbind(na.omit(feb1data),na.omit(feb2data))
colnames(data) <- colnames(hdr)
hist(data$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)", xlim=c(0,6), ylim=c(0,1200), xaxt='n')
axis(side=1,at=seq(0,8,2),labels=seq(0,8,2))
dev.copy(png, file="figure/plot1.png", width=480, height=480)
dev.off()
