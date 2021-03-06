### plot2.R
### Script to generate and save plot2.png, to mimic
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
png(file = "plot2.png", width = 480, height = 480)

with(d, plot(Time, Global_active_power, type = 'l', xlab = "", ylab = "Global Active Power (kilowatts)"))

# Close the plotting device
dev.off()
