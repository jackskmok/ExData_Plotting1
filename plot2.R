library(magrittr)

epcsubset <- read.csv("household_power_consumption.txt",sep = ";",stringsAsFactors=FALSE) %>% subset(as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-01","%Y-%m-%d")| as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-02","%Y-%m-%d"))
epcplot2 <- epcsubset[,1:3]
ecpdatetimes <- strptime(paste(epcplot2$Date,epcplot2$Time," "),"%d/%m/%Y %H:%M:%S") %>% cbind(epcplot2)
colnames(ecpdatetimes)[1] <- c("datetime")

plot(ecpdatetimes$datetime,as.numeric(ecpdatetimes$Global_active_power),
     ylab = "Global Active Power(killowatts)", xlab= "", type = "n")
par(col="black")
lines(ecpdatetimes$datetime,as.numeric(ecpdatetimes$Global_active_power), type = "S")

dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the