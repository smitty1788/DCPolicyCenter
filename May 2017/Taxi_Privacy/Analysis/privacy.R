# Analysis of Taxi Trip Privacy in Washington D.C.
# For: D.C. Policy Center
# Author: Randy Smith

library(doMC)
library(tidyverse)
library(lubridate)
registerDoMC(cores = 4)

# set working directory
setwd("G:/DC Policy Center/Taxi_Privacy/Data")

# read in data
cabtrips <- read.csv("G:/DC Policy Center/Taxicabs/Data/Tab/Tidy/cabtrips.csv", stringsAsFactors = FALSE)

# filter dropoffs at US Dept of Interior
usdi <- cabtrips %>% 
  filter(dropLon <= -77.041687 & dropLon >= -77.043505,
         dropLat <= 38.895455 & dropLat >= 38.893545)

# Summary of what neighborhoods USDI employees were picked up in
usdi_ns <- usdi %>% 
  filter(dHR >= 5 & dHR <= 11) %>% 
  group_by(pickHood) %>% 
  summarise(trips = n(),
            avgfare = mean(meterFare),
            avgtip = mean(tip),
            avgdist = mean(tripMile),
            avgtime = mean(tripTime)) %>% 
  mutate(p_trips = trips / sum(trips) * 100) %>% 
  arrange
(desc(p_trips))

# filter dropoffs at World Bank
worldbank <- cabtrips %>% 
  filter(dropLon <= -77.041630 & dropLon >= -77.043514,
         dropLat <= 38.899611 & dropLat >= 38.898296)

# Summary of what neighborhoods World Bank employees were picked up in
worldbank_ns <- worldbank %>% 
  filter(dHR >= 5 & dHR <= 11) %>% 
  group_by(pickHood) %>% 
  summarise(trips = n(),
            avgfare = mean(meterFare),
            avgtip = mean(tip),
            avgdist = mean(tripMile),
            avgtime = mean(tripTime)) %>% 
  mutate(p_trips = trips / sum(trips) * 100) %>% 
  arrange(desc(p_trips))


# Write to csv for us in charts/maps
write.csv(usdi, "Tab/Tidy/usdi.csv", row.names = FALSE)
write.csv(worldbank, "Tab/Tidy/worldbank.csv", row.names = FALSE)
write.csv(usdi_ns, "Tab/Tidy/usdi_ns.csv", row.names = FALSE)
write.csv(worldbank_ns, "Tab/Tidy/worldbank_ns.csv", row.names = FALSE)
