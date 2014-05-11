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
# Convert "Global_active_power" data to numeric through character, 
# because it's a factor
data3[, 3] <- as.numeric(as.character(data3$Global_active_power))

GAP <- data3$Global_active_power

# Combine date and time and covert it to the normal format
dataTime <- strptime(paste(data3$Date, data3$Time), "%Y-%m-%d %H:%M:%S")

# Start making plit
png(filename = "Plot2.png",
    width = 480, height = 480, bg = "transparent")
par(mfrow = c(1, 1))
plot(dataTime, GAP, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()