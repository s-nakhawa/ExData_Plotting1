# Plot 3
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



# Create plot3.png
png(filename = "plot3.png")
plot(x = datetime, y = hpc$sub_metering_1, 
     type = "n", 
     xlab = "", 
     ylab = "Energy sub metering")
lines(datetime, hpc$sub_metering_1, col = "black")
lines(datetime, hpc$sub_metering_2, col = "red")
lines(datetime, hpc$sub_metering_3, col = "blue")
legend("topright", 
       col = c("black", "red", "blue"), lty = c(1, 1, 1), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()