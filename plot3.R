library(dplyr)
library(tidyr)
library(lubridate)
library(data.table)


# Construct the plot and save it to a PNG file 
# with a width of 480 pixels and a height of 480 pixels.

# Name each of the plot files as plot1.png, plot2.png, etc.

# Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot,
# i.e. code in plot1.R constructs the plot1.png plot.

# Your code file should include code for reading the data so that the plot can be fully reproduced.

# You should also include the code that creates the PNG file.

# Add the PNG file and R code file to your git repository



#Read in file with fread from data.table package
df <- fread("household_power_consumption.txt",
            na.strings = c("NA","N/A","","?"))



#Format date field
df$Date <- dmy(df$Date)

#Add column with name of Month, year, and day of month
df$Month <- months(df$Date)
df$Year <- year(df$Date)
df$Day <- day(df$Date)
df$Weekday <- weekdays(df$Date)


#Create an object which represents the days we'll be filtering to
days <- c(1,2)

#Subset
dat <- subset(df, Year == "2007" & Month == "February" & Day %in% days)

#Paste the date and time field together
dat$dateTime <- paste(dat$Date, dat$Time, sep = " ")


# Set class of new field as date
dat$dateTime <- ymd_hms(dat$dateTime)



#######################
#Create plot 3
with(dat, plot(dateTime, Sub_metering_1,
               type = "l",
               xlab = "",
               ylab = "Energy Submetering"))
with(dat, lines(dateTime, Sub_metering_2,
              type = "l",
              col = "red"))
with(dat, lines(dateTime, Sub_metering_3,
              type = "l",
              col = "blue"))
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, 
       lwd=1, 
       col=c("black", "red", "blue"))

#Save as .png 
png('plot3.png', width = 480, height = 480)
with(dat, plot(dateTime, Sub_metering_1,
               type = "l",
               xlab = "",
               ylab = "Energy Submetering"))
with(dat, lines(dateTime, Sub_metering_2,
                type = "l",
                col = "red"))
with(dat, lines(dateTime, Sub_metering_3,
                type = "l",
                col = "blue"))
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, 
       lwd=1, 
       col=c("black", "red", "blue"))
dev.off()











