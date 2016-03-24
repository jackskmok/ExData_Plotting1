library(magrittr)
library(reshape2)

epcsubset <- read.csv("household_power_consumption.txt",sep = ";") %>% 
                      subset(as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-01","%Y-%m-%d")| 
                             as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-02","%Y-%m-%d"))

epcplot3 <- epcsubset[,c("Date","Time","Sub_metering_1","Sub_metering_2","Sub_metering_3")]
ecpdatetimes <- strptime(paste(epcplot3$Date,epcplot3$Time," "),"%d/%m/%Y %H:%M:%S") %>% cbind(epcplot3)
colnames(ecpdatetimes)[1] <- c("datetime")

ecpMelt <- melt(ecpdatetimes, id=c("datetime"),measure.vars = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
colnames(ecpMelt)[2] <- "metering"

with(ecpMelt, plot(ecpMelt$datetime,ecpMelt$value,ylab="Energy sub metering", xlab="",type = "n"))
with(subset(ecpMelt,metering == "Sub_metering_1"),lines(datetime,value,col = "black"))
with(subset(ecpMelt,metering == "Sub_metering_2"),lines(datetime,value,col = "red"))
with(subset(ecpMelt,metering == "Sub_metering_3"),lines(datetime,value,col = "blue"))
legend("topright", lty=1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png, file = "plot3.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close th