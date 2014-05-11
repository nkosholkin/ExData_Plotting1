# first, please set your working directory to the folder 
# with data with setwd() function

# If you ran this code, days on x-axis should be in your local language

# read table
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, sep = ";")
# find only February 1 and 2.
data2 <- data[(data$Date == "1/2/2007" | 
                       data$Date == "2/2/2007"), ]
# get rid of NA values.
data3 <- data2[complete.cases(data2),]

# convert data
data3[, 1] <- as.Date(data3$Date, "%d/%m/%Y")

# convert data to numeric
data3[, 3] <- as.numeric(as.character(data3$Global_active_power))
data3[, 4] <- as.numeric(as.character(data3$Global_reactive_power))
data3[, 5] <- as.numeric(as.character(data3$Voltage))
data3[, 7] <- as.numeric(as.character(data3$Sub_metering_1))
data3[, 8] <- as.numeric(as.character(data3$Sub_metering_2))
data3[, 9] <- as.numeric(as.character(data3$Sub_metering_3))

dataTime <- strptime(paste(data3$Date, data3$Time), "%Y-%m-%d %H:%M:%S")

GAP <- data3$Global_active_power

# Start making plot
png(filename = "Plot4.png",
    width = 480, height = 480)

# set up 2 by 2 "matrix" of graph in one graph
par(mfrow = c(2, 2))

# first graph
plot(dataTime, GAP, type = "l", 
     xlab = "", ylab = "Global Active Power", bg = "transparent")

# second graph
plot(dataTime, data3$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage", bg = "transparent")

# third graph
plot(dataTime, data3$Sub_metering_1, type = "l", 
     box(lwd=0.5), xlab = "", ylab = "Energy sub metering", 
     ylim = c(0, max(data3$Sub_metering_1)), bg = "transparent")
par(new = TRUE)
plot(dataTime, data3$Sub_metering_2, type = "l", 
     xlab = "", ylab = "", ylim = c(0, max(data3$Sub_metering_1)), 
     col = "red", bty ="n",axes=F, bg = "transparent")
par(new = TRUE)
plot(dataTime, data3$Sub_metering_3, type = "l", 
     xlab = "", ylab = "", ylim = c(0, max(data3$Sub_metering_1)), 
     col = "blue", bty ="n",axes=F, bg = "transparent")
par(new = FALSE)
legend("topright", lty=1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty = "n", cex=0.8, yjust = 1)
# fourth graph
plot(dataTime, data3$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power", bg = "transparent")

dev.off()