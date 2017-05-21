### plot3.R
### Script to generate and save plot3.png, to mimic
### as closely as possible the example in the /figure subfolder
### 
### Data file must be saved in the /data subfolder within 
### working directory in order to load

library(ggplot2)

# Load data
d = read.csv("./data/household_power_consumption.txt", sep = ";")

# Convert date and time fields to date and date-time types respectively
d$Date = as.Date(d$Date, "%d/%m/%Y")
d$Time = strptime(paste(d$Date, d$Time), "%Y-%m-%d %H:%M:%S")

# Keep only dates between 2007-02-01 and 2007-02-02 inclusive
d = subset(d, Date >= '2007-02-01' & Date <= '2007-02-02')


# Convert all columns apart from date and time to numeric,
# instead of factor type which they load in as
d[,-(1:2)] = apply(d[,-(1:2)], 2, function(x) as.numeric(as.character(x)))

# Plot the chart to png file

png(file = "plot3.png", width = 480, height = 480)

with(d, plot(Time, Sub_metering_1, type = 'l', xlab = "", ylab = "Energy sub metering"))
with(d, lines(Time, Sub_metering_2, col = 'red'))
with(d, lines(Time, Sub_metering_3, col = 'blue'))

legend(x = 'topright', c('Sub_metering_1', 'Sub_metering_2', "Sub_metering_3"),
       lty = 1, col = c('black', 'red', 'blue'))

# Close the plotting device
dev.off()
