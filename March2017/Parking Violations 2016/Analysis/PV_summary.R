library(tidyverse)
library(plyr)

# Raw data aquired through the D.C Open Data Portal at http://opendata.dc.gov

#load datasets
pvjan16 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_January_2016.csv")
pvfeb16 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_February_2016.csv")
pvmar16 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_March_2016.csv")
pvapr16 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_April_2016.csv")
pvmay16 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_May_2016.csv")
pvjun16 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_June_2016.csv")
pvjul16 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_July_2016.csv")
pvaug16 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_August_2016.csv")
pvsep16 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_September_2016.csv")
pvoct16 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_October_2016.csv")
pvnov16 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_November_2016.csv")
pvdec16 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_December_2016.csv")

#load 2015 datasets
pvjan15 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_January_2015.csv")
pvfeb15 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_February_2015.csv")
pvmar15 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_March_2015.csv")
pvapr15 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_April_2015.csv")
pvmay15 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_May_2015.csv")
pvjun15 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_June_2015.csv")
pvjul15 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_July_2015.csv")
pvaug15 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_August_2015.csv")
pvsep15 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_September_2015.csv")
pvoct15 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_October_2015.csv")
pvnov15 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_November_2015.csv")
pvdec15 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_December_2015.csv")

#load 2014 datasets
pvjan14 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_January_2014.csv")
pvfeb14 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_February_2014.csv")
pvmar14 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_March_2014.csv")
pvapr14 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_April_2014.csv")
pvmay14 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_May_2014.csv")
pvjun14 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_June_2014.csv")
pvjul14 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_July_2014.csv")
pvaug14 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_August_2014.csv")
pvsep14 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_September_2014.csv")
pvoct14 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_October_2014.csv")
pvnov14 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_November_2014.csv")
pvdec14 <- read_csv("G:/DC Policy Center/Parking Violations/Data/Tab/Parking_Violations_in_December_2014.csv")


#Combine all months into one file
pv2016 <- rbind(pvjan16, pvfeb16, pvmar16, pvapr16, pvmay16, pvjun16, pvjul16, pvaug16, pvsep16, pvoct16, pvnov16, pvdec16)
pv2015 <- rbind(pvjan15, pvfeb15, pvmar15, pvapr15, pvmay15, pvjun15, pvjul15, pvaug15, pvsep15, pvoct15, pvnov15, pvdec15)
pv2014 <- rbind(pvjan14, pvfeb14, pvmar14, pvapr14, pvmay14, pvjun14, pvjul14, pvaug14, pvsep14, pvoct14, pvnov14, pvdec14)



#Write combined file to csv
write.csv(pv2016, file = "Parking_Violations_2016.csv")
write.csv(pv2015, file = "Parking_Violations_2015.csv")
write.csv(pv2014, file = "Parking_Violations_2014.csv")


#Find frequency of tickets per street segment
Street_ID <- count(pv2016, vars = c("STREETSEGID"))

#write frequency to csv
write.csv(Street_ID, file = "Street_ID.csv")

#Find frequency of tickets per violation
violation <- count(pv2016, vars = c("VIOLATION_DESCRIPTION"))

#write frequency to csv
write.csv(violation, file = "violations.csv")

#Find frequency of tickets per state
state <- count(pv2016, vars = c("RP_PLATE_STATE"))

#write frequency to csv
write.csv(state, file = "states.csv")

# Add Column and Reformat Date to Month Day
pv2016$date <- format(as.Date(pv2016$TICKET_ISSUE_DATE), "%m")
pv2015$date <- format(as.Date(pv2015$TICKET_ISSUE_DATE), "%m")

pv2014$date <- format(as.Date(pv2014$TICKET_ISSUE_DATE), "%m")

# Find Frequency of Tickets by Day of Year
pv_2016_day <- count(pv2016, vars = c("date"))
pv_2015_day <- count(pv2015, vars = c("date"))
pv_2014_day <- count(pv2014, vars = c("date"))

#Rename freq to Year
pv_2016_day <- rename(pv_2016_day, c("freq"="2016"))
pv_2015_day <- rename(pv_2015_day, c("freq"="2015"))
pv_2014_day <- rename(pv_2014_day, c("freq"="2014"))

# write frequencies to csv
write.csv(pv_2016_day, file = "pv_2016_day.csv")
write.csv(pv_2015_day, file = "pv_2015_day.csv")
write.csv(pv_2014_day, file = "pv_2014_day.csv")

#merge datasets by common key of date
pv_16_15 <- merge(x = pv_2016_day, y = pv_2015_day, by = "date", all.x = TRUE)
pv_2014_2016 <- merge(x = pv_16_15, y = pv_2014_day, by = "date", all.x = TRUE)

#write merge to csv
write.csv(pv_2014_2016, file = "pv_2014_2016.csv")
