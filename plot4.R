### Code for creating the plot starts on row 41 !!! ### ### Code for creating the plot starts on row 41 !!! ###

### Code for creating the plot starts on row 41 !!! ### ### Code for creating the plot starts on row 41 !!! ###

#### Required packages 
library(dplyr); library(lubridate)

#### Read the data ####
##                from current working directory, use first row as column names (header=T)
##                separator ";"

dataset <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                      stringsAsFactors = FALSE) 

str(dataset)            ## check the data 
View(head(dataset))     ## check the data

dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y") ## Set "Date" column to Date class

#### select only the data what we need #### 
HP_data <- filter(dataset, Date == "2007-02-01" | Date == "2007-02-02")

str(HP_data)            ## check the data

HP_data[,3:9] <- sapply(HP_data[,3:9], as.numeric) ## class of 3:9th column to numeric
str(HP_data)            ## check the data

View(head(HP_data))     ## check the data
View(tail(HP_data))     ## check the data
sum(is.na(HP_data))     ## check the data

### Coerced Date and Time to new "Date_time" column and set it to POSIXct class ###
HP_data$Date_time <- strptime(paste(HP_data$Date , HP_data$Time), format="%Y-%m-%d %H:%M:%S")
HP_data$Date_time <- as.POSIXct(HP_data$Date_time)

HP_data <- select(HP_data, -(Date:Time))        ## delete Date and Time columns (we don't need it anymore)
HP_data <- HP_data[,c(8,1,2,3,4,5,6,7)]         ## reorder the columns (Date_time column to first place) 
write.csv(HP_data, file="household_PC.csv")     #### create working file - OPTIONAL !!! ####


#### CREATE PLOT4.PNG #### !!! #### CREATE PLOT4.PNG ####

png(filename="plot4.png", width = 480, height = 480)

par(mfrow = c(2,2)) ## 4 plots in one image (2x2)

#### PLOT1 -> TOPLEFT #### #### PLOT1 -> TOPLEFT ####
with(HP_data, plot(Date_time, Global_active_power, xlab="", ylab="Global Active Power", type="n"))
lines(HP_data$Date_time, HP_data$Global_active_power)

#### PLOT2 -> TOPRIGHT ######## PLOT2 -> TOPRIGHT ####
with(HP_data, plot(Date_time, Voltage, xlab="datetime", ylab="Voltage", type="n"))
lines(HP_data$Date_time, HP_data$Voltage)

#### PLOT3 -> BOTTOMLEFT ######## PLOT3 -> BOTTOMLEFT ####
with(HP_data, plot(Date_time, Sub_metering_1, xlab="", ylab="Energy sub metering", type="n"))
lines(HP_data$Date_time, HP_data$Sub_metering_1, col="black")
lines(HP_data$Date_time, HP_data$Sub_metering_2, col="red")
lines(HP_data$Date_time, HP_data$Sub_metering_3, col="blue")
legend("topright", bty="n", lty=1, col=c("black", "red", "blue"), 
       legend=c( "Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

#### PLOT4 -> BOTTOMRIGHT ######## PLOT4 -> BOTTOMRIGHT ####
with(HP_data, plot(Date_time, Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="n"))
lines(HP_data$Date_time, HP_data$Global_reactive_power)

dev.off()