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


# Open PNG graphics device
png(file = "plot2.png", width = 480, height = 480)
datetimes <- dmy_hms(paste(df$Date, df$Time))


# Set transparent background and plot Graph 1
par(bg = NA)
plot(datetimes, df$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")


# Close graphics device
dev.off()
