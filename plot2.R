# Plot 2
# Load the data
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "powerconsumption.zip", method = "curl")
unzip("powerconsumption.zip")

df <- read.table("household_power_consumption.txt", 
                 sep = ";", 
                 stringsAsFactors = FALSE, 
                 skip = (grep("1/2/2007", readLines("household_power_consumption.txt"))) - 1, 
                 nrows = 2880)
names(df) <- c("Date", "Time", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")
hpc <- tbl_df(df)
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
datetime <- paste(hpc$Date, hpc$Time, sep = " ")
datetime <- strptime(datetime, format = "%Y-%m-%d %H:%M:%S")

# Create plot2.png
png(filename = "plot2.png")
plot(datetime, hpc$global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()