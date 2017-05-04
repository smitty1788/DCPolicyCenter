# Analysis of Taxi Trips in Washington D.C.
# For: D.C. Policy Center
# Author: Randy Smith


library(sqldf)
library(rgdal)
library(lubridate)
library(ggplot2)
library(gridExtra)
library(weatherData)
library(zoo)
library(reshape2)
library(tidyverse)
library(doMC)
library(minpack.lm)
library(hrbrthemes)
library(gcookbook)

registerDoMC(cores = 4)
setwd("G:/DC Policy Center/Taxicabs/Data")

# read in, rename, and combine
cab1505 <- read.delim("Tab/trips_0515_0816/taxi_201505.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1506 <- read.delim("Tab/trips_0515_0816/taxi_201506.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1507 <- read.delim("Tab/trips_0515_0816/taxi_201507.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1508 <- read.delim("Tab/trips_0515_0816/taxi_201508.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1509 <- read.delim("Tab/trips_0515_0816/taxi_201509.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1510 <- read.delim("Tab/trips_0515_0816/taxi_201510.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1511 <- read.delim("Tab/trips_0515_0816/taxi_201511.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1512 <- read.delim("Tab/trips_0515_0816/taxi_201512.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1601 <- read.delim("Tab/trips_0515_0816/taxi_201601.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1602 <- read.delim("Tab/trips_0515_0816/taxi_201602.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1603 <- read.delim("Tab/trips_0515_0816/taxi_201603.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1604 <- read.delim("Tab/trips_0515_0816/taxi_201604.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1605 <- read.delim("Tab/trips_0515_0816/taxi_201605.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1606 <- read.delim("Tab/trips_0515_0816/taxi_201606.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1607 <- read.delim("Tab/trips_0515_0816/taxi_201607.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1608 <- read.delim("Tab/trips_0515_0816/taxi_201608.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)

# removing rows with incomplete data
ccab1505 <- cab1505 %>% na.omit()
ccab1506 <- cab1506 %>% na.omit()
ccab1507 <- cab1507 %>% na.omit()
ccab1508 <- cab1508 %>% na.omit()
ccab1509 <- cab1509 %>% na.omit()
ccab1510 <- cab1510 %>% na.omit()
ccab1511 <- cab1511 %>% na.omit()
ccab1512 <- cab1512 %>% na.omit()
ccab1601 <- cab1601 %>% na.omit()
ccab1602 <- cab1602 %>% na.omit()
ccab1603 <- cab1603 %>% na.omit()
ccab1604 <- cab1604 %>% na.omit()
ccab1605 <- cab1605 %>% na.omit()
ccab1606 <- cab1606 %>% na.omit()
ccab1607 <- cab1607 %>% na.omit()
ccab1608 <- cab1608 %>% na.omit()

# combine all df thats na was omitted
cabs <- rbind(ccab1505, ccab1506, ccab1507, ccab1508, ccab1509, ccab1510, ccab1511, 
              ccab1512, ccab1601, ccab1602, ccab1603, ccab1604, ccab1605, ccab1606,
              ccab1607, ccab1608)

# combine all df with full data
full_cabs <- rbind(cab1505, cab1506, cab1507, cab1508, cab1509, cab1510, cab1511, 
                   cab1512, cab1601, cab1602, cab1603, cab1604, cab1605, cab1606,
                   cab1607, cab1608)




# rename columns of both combined datasets
colnames(cabs) <- c("tripNo","triptype","payProvider","meterFare","tip","surcharge","extras",
                     "tolls","totalAmt","payType","card","pickupCity","pickupSt","pickupZip",
                     "dropoffCity","dropoffSt","dropoffZip","tripMile","tripTime","pickLat","pickLon",
                     "pickblk","dropLat","dropLon","dropblk","airport","pickupDT","dropoffDT")

colnames(full_cabs) <- c("tripNo","triptype","payProvider","meterFare","tip","surcharge","extras",
                    "tolls","totalAmt","payType","card","pickupCity","pickupSt","pickupZip",
                    "dropoffCity","dropoffSt","dropoffZip","tripMile","tripTime","pickLat","pickLon",
                    "pickblk","dropLat","dropLon","dropblk","airport","pickupDT","dropoffDT")





provider <- cabs %>%
  mutate(payProvider = as.character(payProvider)) %>% 
  na.omit() %>% 
  group_by(payProvider) %>% 
  count() %>% 
  arrange(desc(n))

# Covert to standard time format, calculate day and hour
cabs <- cabs %>%
  mutate(pickupDT=as.POSIXct(pickupDT, format="%m/%d/%Y %H:%M", tz="America/New_York"),
         dropoffDT=as.POSIXct(dropoffDT, format="%m/%d/%Y %H:%M", tz="America/New_York"),
         pDay = wday(pickupDT),
         pHR = hour(pickupDT),
         dDay = wday(dropoffDT),
         dHR = hour(dropoffDT))

full_cabs <- full_cabs %>%
  mutate(pickupDT=as.POSIXct(pickupDT, format="%m/%d/%Y %H:%M", tz="America/New_York"),
         dropoffDT=as.POSIXct(dropoffDT, format="%m/%d/%Y %H:%M", tz="America/New_York"),
         pDay = wday(pickupDT),
         pHR = hour(pickupDT),
         dDay = wday(dropoffDT),
         dHR = wda(dropoffDT))



pick <- cabs %>% 
  select(pickLon, pickLat, tripNo)

drop <- cabs %>% 
  select(dropLon, dropLat, tripNo)


# Download and read GeoJSON file
u <- "http://ec2-54-235-58-226.compute-1.amazonaws.com/storage/f/2013-05-12T03%3A50%3A18.251Z/dcneighorhoodboundarieswapo.geojson"
downloader::download(url = u, destfile = "G:/DC Policy Center/Taxicabs/Data/dcnhb.GeoJSON")
hood <- readOGR(dsn = "G:/DC Policy Center/Taxicabs/Data/dcnhb.GeoJSON", layer = "OGRGeoJSON")

# Add pickup/dropff points to Spatial points
addAll <- SpatialPoints(pick, proj4string=CRS(as.character("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")))
dropAll <- SpatialPoints(drop, proj4string=CRS(as.character("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")))

# Perfom Spatial Join
puHood <- over(addAll, hood)
doHood <- over(dropAll, hood)

puH <- cbind(pick, puHood)
doH <- cbind(drop, doHood)

trip <- cbind(puH, doH)

colnames(trip) <- c("pickLonx","pickLatx", "tripNo", "picknID", "pickQuad", "pickHood",
                    "dropLonx", "dropLatx", "droptrip", "dropnID", "dropQuad", "dropHood")
  


cabtrips <- merge(x = cabs, y = trip, by = "tripNo", all.x = TRUE, all.y = TRUE) %>% 
 
   mutate(pickQuad = as.character(pickQuad),
         pickHood = as.character(pickHood),
         dropQuad = as.character(dropQuad),
         dropHood = as.character(dropHood)) %>% 
 
   select(tripNo, triptype, payProvider, meterFare, tip, 
         surcharge, extras,tolls, totalAmt, payType, card, 
         pickLat, pickLon, pickQuad, pickHood, picknID, pickupCity, 
         pickupSt, pickupZip,dropoffCity, dropLat, dropLon, 
         dropQuad, dropHood, dropnID, dropoffSt, dropoffZip, 
         tripMile, tripTime, pickblk, dropblk, airport, pickupDT, 
         dropoffDT, pDay, pHR, dDay, dHR)

write.csv(cabtrips, "Tab/Tidy/cabtrips.csv", row.names = FALSE)
cabtrips <- read.csv("Tab/Tidy/cabtrips.csv", stringsAsFactors = FALSE)

write.csv(full_cabs, "Tab/Tidy/fullcabs.csv", row.names = FALSE)


#-------------------------------------------------------------------------------------------------------------------
# Summary of Hood to Hood trips
sum_cab <- cabtrips %>%
  group_by(pickHood, dropHood) %>% 
  summarise(trips = n(),
            avgfare = median(meterFare),
            avgTip = mean(tip),
            avgTime = median(tripTime),
            avgDist = median(tripMile),
            dropnID = mean(dropnID)) %>% 
  arrange(desc(trips))

sum_quad <- cabtrips %>%
  group_by(pickQuad, dropQuad) %>% 
  summarise(trips = n(),
            avgfare = median(meterFare),
            avgTip = mean(tip),
            avgTime = median(tripTime),
            avgDist = median(tripMile),
            dropnID = mean(dropnID)) %>% 
  arrange(desc(trips))
write.csv(sum_quad, "Tab/Tidy/quad.csv", row.names = FALSE)


# Summary of trips originating in downtown
downtown <- sum_cab %>% 
  filter(pickHood == "Downtown") %>% 
  mutate(Percent = trips / sum(trips) * 100)

# summary of trip times from downtown to dupont
downtown_times <- cabtrips %>% 
  filter(pickHood == "Downtown" & dropHood == "Dupont Circle") %>% 
  mutate(day = as.numeric(if_else(pDay == 1, 7,
                                    if_else(pDay == 2, 1,
                                            if_else(pDay == 3, 2,
                                                    if_else(pDay == 4, 3,
                                                            if_else(pDay == 5, 4,
                                                                    if_else(pDay == 6, 5,
                                                                            if_else(pDay == 7, 6, 50))))))))) %>% 
  group_by(day, pHR) %>% 
  summarise(count = n()) %>% 
  arrange(day)


  
# Summary of trips originating in dupont
dupont <- sum_cab %>% 
  filter(pickHood == "Dupont Circle") %>% 
  mutate(Percent = trips / sum(trips) * 100)

# summary of trip times from downtown to dupont
dupont_times <- cabtrips %>% 
  filter(pickHood == "Dupont Circle" & dropHood == "Downtown") %>% 
  mutate(day = as.numeric(if_else(pDay == 1, 7,
                                  if_else(pDay == 2, 1,
                                          if_else(pDay == 3, 2,
                                                  if_else(pDay == 4, 3,
                                                          if_else(pDay == 5, 4,
                                                                  if_else(pDay == 6, 5,
                                                                          if_else(pDay == 7, 6, 50))))))))) %>% 
  group_by(day, pHR) %>% 
  summarise(count = n()) %>% 
  arrange(day, pHR)



ustreet <- sum_cab %>% 
  filter(pickHood == "U Street") %>% 
  mutate(Percent = trips / sum(trips) * 100)

# summary of trip times from downtown to dupont
ustreet_times <- cabtrips %>% 
  filter(pickHood == "U Street" & dropHood == "Columbia Heights") %>% 
  mutate(day = as.numeric(if_else(pDay == 1, 7,
                                  if_else(pDay == 2, 1,
                                          if_else(pDay == 3, 2,
                                                  if_else(pDay == 4, 3,
                                                          if_else(pDay == 5, 4,
                                                                  if_else(pDay == 6, 5,
                                                                          if_else(pDay == 7, 6, 50))))))))) %>% 
  group_by(day, pHR) %>% 
  summarise(count = n()) %>% 
  arrange(day, pHR)



write.csv(sum_cab, "Tab/Tidy/summary_by_hood.csv")
write.csv(downtown, "Tab/Tidy/downtown_trips.csv", row.names = FALSE)
write.csv(downtown_times, "Tab/Tidy/downtown_times.csv", row.names = FALSE)
write.csv(dupont_times, "Tab/Tidy/dupont_times.csv", row.names = FALSE)
write.csv(ustreet_times, "Tab/Tidy/ustreet_times.csv", row.names = FALSE)
write.csv(dupont, "Tab/Tidy/dupont_trips.csv", row.names = FALSE)
write.csv(ustreet, "Tab/Tidy/ustreet_trips.csv", row.names = FALSE)



#-------------------------------------------------------------------------------------------------------------------

full_cabs <- read.csv("Tab/Tidy/fullcabs.csv", stringsAsFactors = FALSE)
cab_day <- full_cabs %>% 
  mutate(ShortDate = as.Date(pickupDT, "%Y-%m-%d %H:%M:%S")) %>% 
  group_by(ShortDate) %>% 
  summarise(Trips = n(),
            medfare = median(meterFare, na.rm = TRUE),
            medTip = mean(tip, na.rm = TRUE),
            medTime = median(tripTime, na.rm = TRUE),
            medDist = median(tripMile, na.rm = TRUE)) %>% 
  subset(ShortDate > as.Date("2016-03-31") |  ShortDate < as.Date("2016-03-01")) %>%
  subset(ShortDate > as.Date("2015-06-30") |  ShortDate < as.Date("2015-06-01")) %>% 
  mutate(rolltrip = rollsum(Trips, k = 28, na.pad = TRUE, align = "right"),
         rollavg = rollmean(Trips, k = 28, na.pad = TRUE, align = "right"))

write.csv(cab_day, "Tab/Tidy/cab_day.csv", row.names = FALSE)


# Create line graph for birth rates from 2009 to 2015
ggplot(data = cab_day, aes(x = ShortDate, y = rollavg)) +
  geom_line(size = 1.5, se = FALSE, color = "#527394") +
  ylim(c(0, 50000)) +
  labs(x = "Date", y = "Taxi Trips, 28 Day Trailing Average",
       title = "Taxi Trips by Day",
       subtitle = "Washington, D.C. July 2015 to August 2016",
       caption = "Source: D.C. Open Data") + 
  theme_ipsum_rc()

#-------------------------------------------------------------------------------------------------------------------
# Trip prediction model based on weather

# Aquire weather data from weather package
w1 <- getSummarizedWeather("DCA", start_date = "2015-05-01", end_date = "2015-12-31", station_type = "id", opt_all_columns = TRUE)
w2 <- getSummarizedWeather("DCA", start_date = "2016-01-01", end_date = "2016-09-01", station_type = "id", opt_all_columns = TRUE) %>% 
  rename(EST = EDT)

weather <- rbind(w1, w2) %>% 
  transform(Date = as.character(Date))
weather$PrecipitationIn <- gsub("T", "0.01", weather$PrecipitationIn)

# Merge Cab Summary and weather data
cab_weather <- cab_day %>% 
  transform(ShortDate = as.character(ShortDate)) %>% 
  merge(y = weather, by.x = "ShortDate", by.y = "Date", all.x = TRUE) %>% 
  mutate(ShortDate = as.Date(ShortDate, "%Y-%m-%d"),
         PrecipitationIn = as.numeric(PrecipitationIn))
write.csv(cab_weather, "Tab/Tidy/weather.csv", row.names = FALSE)


# Clean up data for model
wmodel <- cab_weather %>% 
  select(ShortDate,
         Trips,
         PrecipitationIn,
         Max_TemperatureF,
         Max_Humidity) %>%
  mutate(dow = wday(ShortDate),
         month = month(ShortDate),
         year = year(ShortDate),
         weekday = if_else(dow >= 1 & dow <= 5, "TRUE", "FALSE"),
         weekday_non_holiday = dow %in% 1:5)




plot <- wmodel %>%
  mutate(precip_bucket = cut(PrecipitationIn, breaks = c(0, 0.0001, 0.2, 0.4, 0.6, 6), right = FALSE),
         temp_bucket = cut(Max_TemperatureF, breaks = c(25, 35, 45, 55, 65, 75, 85, 95, 105), right = FALSE),
         humid_bucket = cut(Max_Humidity, breaks = c(40, 50, 60, 70, 80, 90, 100), right = FALSE),
         taxi_week_avg = rollmean(Trips, k = 7, na.pad = TRUE, align = "right"))


# Data brokendown by average trips by precipitation, temperature, and humidity
precip <- plot %>%
  group_by(precip_bucket) %>%
  summarize(Trips = mean(Trips), days = n())
write.csv(precip, "Tab/Tidy/precip.csv", row.names = FALSE)

temp <- plot %>%
  group_by(temp_bucket) %>%
  summarize(Trips = mean(Trips), days = n())
write.csv(temp, "Tab/Tidy/temp.csv", row.names = FALSE)

humid <- plot %>%
  group_by(humid_bucket) %>%
  summarize(Trips = mean(Trips), days = n())
write.csv(humid, "Tab/Tidy/humid.csv", row.names = FALSE)

  



# Non-linear Least Square Model
scurve = function(x, center, width) {
  1 / (1 + exp(-(x - center) / width))
}
nls_model = nlsLM(
  Trips ~ exp(
    const +
      b_weekday * weekday_non_holiday
  ) +
    b_weather * scurve(
      Max_TemperatureF + b_precip * PrecipitationIn + b_humid * Max_Humidity,
      weather_scurve_center,
      weather_scurve_width
    ),
  data = wmodel,
  start = list(const = 9,
               b_weekday = 1,
               b_weather = 25000,
               b_precip = -20,
               b_humid = -2,
               weather_scurve_center = 45,
               weather_scurve_width = 20))

summary(nls_model)
sqrt(mean(summary(nls_model)$residuals^2))
# 11324.42



# Apply model to data 
cabweatherdata <- wmodel %>%
  mutate(predicted_nls = predict(nls_model, newdata = cabweatherdata),
         resid = Trips - predicted_nls) %>%
  mutate(rollobserve = rollsum(Trips, k = 28, na.pad = TRUE, align = "right"),
         rollpredict = rollsum(predicted_nls, k = 28, na.pad = TRUE, align = "right"))


# Reshape data to plot
predicted_by_date = cabweatherdata %>% 
  select(ShortDate, rollobserve, rollpredict) %>% 
  gather(`rollobserve`, `rollpredict`, key ="Type", value = Trips)


# set color scheme and legend labels
col <- c("#527394", "#8BCFC5")
demo <- c("Observed", "Predicted")

# Create line graph for birth rates from 2009 to 2015
ggplot(data = predicted_by_date, aes(x = ShortDate, y = Trips, color = Type)) +
  geom_line(size = 1.5, se = FALSE) +
  ylim(c(0,1250000)) +
  scale_colour_manual(labels = demo, values = col) +
  labs(color = "Taxi Trips",
       x = "Date, July 2015 to August 2016", y = "Taxi Trips, 28 Day Trailing Count",
       title = "Daily Taxi Trips: Actual vs. Model",
       caption = "Source: D.C. Open Data") + 
  theme_ipsum_rc()



# triptype, payProvider, meterFare, tip, 
# surcharge, extras,tolls, totalAmt, payType, card, pickupCity, 
# pickupSt, pickupZip,dropoffCity, dropoffSt, dropoffZip, tripMile, 
# tripTime, pickblk, dropblk, airport, pickupDT, 
# dropoffDT, pDay, pHR, dDay, dHR
