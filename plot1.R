library(magrittr)
epcsubset <- read.csv("household_power_consumption.txt",sep = ";", stringsAsFactors=FALSE) %>% subset(as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-01","%Y-%m-%d")| as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-02","%Y-%m-%d"))
epcplot1 <- epcsubset[,1:3]
hist(as.numeric(as.character(epcplot1$Global_active_power)),xlab = "Global Active Power (Kilowatts)",
     ylab = "Frequency",col="red", main = "Global Active Power")

dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the