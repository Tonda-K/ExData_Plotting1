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


#### CREATE PLOT1.PNG #### !!! #### CREATE PLOT1.PNG ####

png(filename="plot1.png", width = 480, height = 480)
hist(HP_data$Global_active_power, col="red", xlab="Global Active Power (killowats)", main="Global Active Power")
dev.off()

