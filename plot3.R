# Preliminaries:
# Load the needed packages
packages <- c("data.table", "dplyr", "lubridate")
sapply(packages, require, character.only=TRUE, quietly=TRUE)


# Get the data from the source:
# A `data` folder will be created and the zip file will be saved
if(!file.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./data/Dataset.zip")


# Unzip the file:
# A new directory named `UCI HAR Dataset` will be created in your working directory 
# when the file is unzipped. 
unzip("./data/Dataset.zip")


# Read only the data we need using the pipe function and regexp!!!
# stringAsFactors = FALSE to read the Date and Time column as chr
df <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),
                 stringsAsFactors = FALSE, sep = ";", na.strings = "?")


# Read the column names from the original file 
df_colnames <- readLines("household_power_consumption.txt", n=1) %>% strsplit(";") %>% unlist()


# Assign proper column names to the data frame
colnames(df) <- df_colnames


# Consider Dates and Times columns as POSIXct objects
datetimes <- dmy_hms(paste(df$Date, df$Time))


# Open PNG graphics device
png(file = "plot3.png", width = 480, height = 480)


# Set transparent background and plot Graph 3
par(bg = NA)
plot(datetimes, df$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(datetimes, df$Sub_metering_2, col = "red")
lines(datetimes, df$Sub_metering_3, col = "blue")


# Set a legend for Graph 3
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lwd=c(1, 1, 1))


# Close graphics device
dev.off()
