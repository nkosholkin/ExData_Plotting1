# first, please set your working directory to the folder 
# with data with setwd() function

# read table
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, sep = ";")
# find only February 1 and 2.
data2 <- data[(data$Date == "1/2/2007" | 
                       data$Date == "2/2/2007"), ]
# get rid of NA values.
data3 <- data2[complete.cases(data2),]

# start making plot
png(filename = "Plot1.png",
    width = 480, height = 480, bg = "transparent")
par(mfrow = c(1, 1))
# Convert "Global_active_power" data to numeric through character, 
# because it's a factor
hist(as.numeric(as.character(data3$Global_active_power)), 
     col = "Red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()
# setwd("/Users/nkosholkin/Dropbox/Education/Coursera/DataScience/EDA")