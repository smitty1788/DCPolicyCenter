# Car free livibility index for Washington D.C.
# For: D.C. Policy Center
# Author: Randy Smith

library(ggthemes)
source('G:/DC Policy Center/fivethirtyeight.r')
library(rgdal)
library(lubridate)
library(tidyverse)
library(tidycensus)



#--------------------------------------------------------------------------------------------------------------------------
# Demographic Data from Census API

setwd("G:/DC Policy Center/Car_Free/Data")


census_api_key("8b5d3a4726e6bd0e6c47ab773476281d0e653fce")

# Load variable list
dc15 <- load_variables(2015, "acs5", cache = TRUE)


variables_df <- tibble(
  "varible_name" = c('MHI', 'Total_Households', 
                     'House_No_Car', 'House_1_No_Car', 'House_2_No_Car', 'House_3_No_Car', 'House_4p_No_Car',
                     'Total_Workers', 'Worker_No_vehicle', 
                     'Public_trans', 'Public_trans_No_Car', 'Public_trans_1car', 'Public_trans_2car', 'Public_trans_3car',
                     'Walk', 'Walk_No_Car', 'Walk_1car', 'Walk_2car', 'Walk_3car',
                     'Taxi_Bike', 'Taxi_Bike_No_Car', 'Taxi_Bike_1car', 'Taxi_Bike_2car', 'Taxi_Bike_3car',
                     'Race_Total', 'White', 'Black', 'Asian', 'Hispanic'),
  "variable_code" = c('B19013_001E', 
                      'B08201_001E', 'B08201_002E', 'B08201_008E', 'B08201_014E', 'B08201_020E', 'B08201_026E',
                      'B08141_001E', 'B08141_002E', 
                      'B08141_016E', 'B08141_017E', 'B08141_018E', 'B08141_019E', 'B08141_020E',
                      'B08141_021E', 'B08141_022E', 'B08141_023E', 'B08141_024E', 'B08141_025E',
                      'B08141_026E', 'B08141_027E', 'B08141_028E', 'B08141_029E', 'B08141_030E',
                      'B02001_001E', 'B02001_002E', 'B02001_003E', 'B02001_005E', 'B03002_012E')
)

years <- c(2009:2015)


# Limit of 25 variable calls, split into two dataframes
dc1 <- get_acs(geography = "tract", variables = head(variables_df$variable_code, 24), state = "DC", county = "001")
dc2 <- get_acs(geography = "tract", variables = tail(variables_df$variable_code, 5), state = "DC", county = "001")


# rbind seperate variable calls
dc <- rbind(dc1, dc2) %>% 
  arrange(GEOID)


# Long to wide format
dc_estimates <- dc %>% 
  select(-(moe), -(NAME)) %>% 
  spread(variable, `estimate`)

# Long to Wide format
dc_moe <- dc %>% 
  select(-(estimate), -(NAME)) %>% 
  spread(variable, `moe`)

colnames(dc_moe)[2:30] <- paste(colnames(dc_moe[,c(2:30)]), "moe", sep = "_")

dc_acs <- merge(dc_estimates, dc_moe, by = 'GEOID')


#--------------------------------------------------------------------------------------------------------------------------
# Calculate Avg Car2Go Availibility
setwd("G:/DC Policy Center/Car2Go/Data/Tab")

# file list
files <- list.files(pattern = "*.csv")

#file names
names <- c('d1', 'd2', 'd3','d4', 'd5','d6','d8','d9', 'd10', 'd11', 'd13',
           'd14', 'd15', 'd16', 'd17',
           'd18', 'd19', 'd20', 'd21',
           'd22', 'd23', 'd24', 'd25', 'd26', 'd27')
# Read in data
for (i in 1:length(files)){
  assign(names[i], 
         read.csv(files[i], stringsAsFactors = FALSE)
  )}

# Bind all dataframes. Set Unique IDs
time_df <- rbind(d1, d2, d3, d4, d5, 
                 d6, d8, d9, d10, d11, 
                 d13, d14, d15, d16, 
                 d17, d18, d19, d20, d21,
                 d22, d23, d24, d25, d26, d27) %>% 
  rename(UID = X) %>% 
  mutate(UID = row_number())

rm(d1, d2, d3, d4, d5, d6, d8, d9, d10, d11, d13,
   d14, d15, d16, d17,
   d18, d19, d20, d21,
   d22, d23, d24, d25, d26, d27)


# Reset WD
setwd("G:/DC Policy Center/Car_Free/Data")

# Subset Longitude/Latitude
c2g <- time_df %>%
  select(Longitude, Latitude)

# read neighborhood GeoJSON file
hood <- readOGR(dsn = "Spatial/CT.geojson", layer = "OGRGeoJSON")

# Add pickup/dropff points to Spatial points
addAll <- SpatialPoints(c2g, proj4string=CRS(as.character("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")))

# Perfom Spatial Join
Hood <- over(addAll, hood)

# Bind to neighborhood info to original df
c2g_Hoods <- cbind(time_df, Hood) %>% 
  mutate(GEOID = as.character(GEOID),
         shortdate = as.Date(Time),
         dow = wday(Time, label = TRUE),
         hour = hour(Time))

#-----------------------------------------------------------------------------------------------------------------------------------
# Avg Taxi Pickups

setwd("G:/DC Policy Center/Taxicabs/Data")

cab1606 <- read.delim("Tab/trips_0515_0816/taxi_201606.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1607 <- read.delim("Tab/trips_0515_0816/taxi_201607.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)
cab1608 <- read.delim("Tab/trips_0515_0816/taxi_201608.txt", sep = "|",  header = T, stringsAsFactors = FALSE, na.strings='NULL', strip.white = TRUE)

ccab1606 <- cab1606 %>% na.omit()
ccab1607 <- cab1607 %>% na.omit()
ccab1608 <- cab1608 %>% na.omit()

# Reset WD
setwd("G:/DC Policy Center/Car_Free/Data")

# combine all df thats na was omitted
cabs <- rbind(ccab1606, ccab1607, ccab1608)

# rename columns of both combined datasets
colnames(cabs) <- c("tripNo","triptype","payProvider","meterFare","tip","surcharge","extras",
                    "tolls","totalAmt","payType","card","pickupCity","pickupSt","pickupZip",
                    "dropoffCity","dropoffSt","dropoffZip","tripMile","tripTime","pickLat","pickLon",
                    "pickblk","dropLat","dropLon","dropblk","airport","pickupDT","dropoffDT")

# Covert to standard time format, calculate day and hour
cabs <- cabs %>%
  mutate(pickupDT=as.POSIXct(pickupDT, format="%m/%d/%Y %H:%M", tz="America/New_York"),
         dropoffDT=as.POSIXct(dropoffDT, format="%m/%d/%Y %H:%M", tz="America/New_York"),
         pDay = wday(pickupDT),
         pHR = hour(pickupDT),
         dDay = wday(dropoffDT),
         dHR = hour(dropoffDT))

pick <- cabs %>% 
  select(pickLon, pickLat, tripNo)



# read CT GeoJSON file
hood <- readOGR(dsn = "Spatial/CT.geojson", layer = "OGRGeoJSON")

# Add pickup/dropff points to Spatial points
addAll <- SpatialPoints(pick, proj4string=CRS(as.character("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")))

# Perfom Spatial Join
puHood <- over(addAll, hood)

puH <- cbind(pick, puHood) %>% 
  select(-(pickLon), -(pickLat), -(tripNo))


cabpickups <- cbind(cabs, puH) %>% 
  mutate(GEOID = as.character(GEOID),
         N_Cluster = as.character(N_Cluster),
         shortdate = as.Date(pickupDT))

#-----------------------------------------------------------------------------------------------------------------------------------
# Calculate Car2Go/Taxi Stats

# Average Hourly Car2Go Availible
c2g_availibilty <- c2g_Hoods %>% 
  group_by(GEOID, N_Cluster, shortdate, hour) %>% 
  summarise(count = n_distinct(name)) %>% 
  group_by(GEOID, N_Cluster) %>% 
  summarise(c2g_avg = mean(count, na.rm = TRUE),
            c2g_median = median(count, na.rm = TRUE),
            c2g_max = max(count, na.rm = TRUE),
            c2g_min = min(count, na.rm = TRUE),
            c2g_sd = sd(count, na.rm = TRUE)) %>% 
  mutate(c2g_range = c2g_max - c2g_min) %>% 
  arrange(desc(c2g_avg)) %>% 
  na.omit()
write.csv(c2g_availibilty, "Tab/Tidy/c2g_availibility.csv", row.names = FALSE)


# Average Hourly Taxi pickups
taxi_availibilty <- cabpickups %>% 
  group_by(GEOID, N_Cluster, shortdate, pHR) %>% 
  summarise(count = n()) %>% 
  group_by(GEOID, N_Cluster) %>% 
  summarise(taxi_avg = mean(count, na.rm = TRUE),
            taxi_median = median(count, na.rm = TRUE),
            taxi_max = max(count, na.rm = TRUE),
            taxi_min = min(count, na.rm = TRUE),
            taxi_sd = sd(count, na.rm = TRUE)) %>%
  mutate(taxi_range = taxi_max - taxi_min) %>% 
  select(-(N_Cluster)) %>% 
  arrange(desc(taxi_avg)) %>% 
  na.omit()
write.csv(taxi_availibilty, "Tab/Tidy/taxi_availibility.csv", row.names = FALSE)

# Merged taxi/c2g availibility
private_transit <- merge(c2g_availibilty, taxi_availibilty, by = 'GEOID', all.x = TRUE, all.y = TRUE)

#-----------------------------------------------------------------------------------------------------------------------------------
# Import scores, calculate carfree livability index

# Averaged walkscore.com scores per census tract
walkscore_scores <- read_csv("Tab/car_free_scores.csv", 
                            col_types = cols(ALAND = col_skip(), 
                                             AWATER = col_skip(), GEOID = col_character(), 
                                             INTPTLAT = col_skip(), INTPTLON = col_skip(), 
                                             NAMELSAD = col_skip(), N_Cluster = col_character(), 
                                             OBJECTID = col_skip(), SHAPE_Area = col_skip(), 
                                             SHAPE_Length = col_skip(), TARGET_FID = col_skip(), 
                                             TARGET_FID_1 = col_skip()))

# Car Free Liviability Index
# Weighted Ranking
# Walk/Transit/Bike Scores weighted to 60%
# Taxi/Car2Go avg weighted to 30%
# CaBi Stations weighted 10%
car_free_index <- walkscore_scores %>% 
  merge(c2g_availibility, by = 'GEOID') %>% 
  merge(taxi_availibility, by = 'GEOID') %>% 
  
  within(R_CaBi_Stations <- as.integer(cut(CaBi_Stations, unique(quantile(CaBi_Stations, probs = 0:10 / 10)), include.lowest=TRUE)) * 25) %>%
  within(R_c2g_avg <- as.integer(cut(c2g_avg, quantile(c2g_avg, probs=0:10/10), include.lowest=TRUE)) * 10) %>%
  within(R_taxi_avg <- as.integer(cut(taxi_avg, quantile(taxi_avg, probs=0:10/10), include.lowest=TRUE)) * 10) %>%
  
  mutate(cfl_index = (0.2 * transit_score) + (0.2 * bike_score) + (0.2 * walkscore) + (0.15 * R_c2g_avg) + (0.15 * R_taxi_avg) + (0.1 * R_CaBi_Stations)) %>% 
  select(-(CaBi_Stations:R_taxi_avg)) %>% 
  rename(N_Cluster = N_Cluster.x)

# Join with ACS Demographics
cfl_index_demo <- car_free_index %>% 
  merge(dc_acs, by = 'GEOID')
write.csv(cfl_index_demo, 'Tab/Tidy/cfl_index.csv', row.names = FALSE)


# Index by Race
cfl_index_race <- cfl_index_demo %>%
  mutate(Score_bin = cut(cfl_index, seq(from = 20, to = 100, by = 10))) %>% 
  select(GEOID, cfl_index, Score_bin, B02001_001, B02001_002, B02001_003, B02001_005, B03002_012) %>% 
  gather(`B02001_002`, `B02001_003`, `B02001_005`, `B03002_012`, key = 'race', value = "estimate") %>%
  group_by(Score_bin, race) %>% 
  summarise(count = n(),
            race_sum = sum(estimate, na.rm = TRUE),
            total_pop = sum(B02001_001, na.rm = TRUE)) %>% 
  mutate(race_prop = race_sum / total_pop * 100)


# Index by Household Size/No Car
cfl_index_house <- cfl_index_demo %>%
  mutate(Score_bin = cut(cfl_index, seq(from = 20, to = 100, by = 10))) %>% 
  select(GEOID, cfl_index, Score_bin, B08201_002, B08201_008, B08201_014, B08201_020, B08201_026) %>% 
  gather(`B08201_008`, `B08201_014`, `B08201_020`, `B08201_026`, key = 'house_size', value = "estimate") %>%
  group_by(house_size, Score_bin) %>% 
  summarise(count = n(),
            house_sum = sum(estimate, na.rm = TRUE),
            total_pop = sum(B08201_002, na.rm = TRUE)) %>% 
  mutate(house_prop = house_sum / total_pop * 100)


# Index by Income
cfl_index_income <- cfl_index_demo %>% 
  mutate(Score_bin = cut(cfl_index, seq(from = 20, to = 100, by = 10))) %>% 
  group_by(Score_bin) %>% 
  summarise(count = n(),
            MHI = mean(B19013_001, na.rm = TRUE),
            moe = sd(B19013_001, na.rm = TRUE))

# Carless households by year
dc_carless_2009 <- get_acs(geography = "state", variables = variables_df$variable_code[2:3], endyear = 2009)
dc_carless_2010 <- get_acs(geography = "state", variables = variables_df$variable_code[2:3], endyear = 2010)
dc_carless_2011 <- get_acs(geography = "state", variables = variables_df$variable_code[2:3], endyear = 2011)
dc_carless_2012 <- get_acs(geography = "state", variables = variables_df$variable_code[2:3], endyear = 2012)
dc_carless_2013 <- get_acs(geography = "state", variables = variables_df$variable_code[2:3], endyear = 2013)
dc_carless_2014 <- get_acs(geography = "state", variables = variables_df$variable_code[2:3], endyear = 2014)
dc_carless_2015 <- get_acs(geography = "state", variables = variables_df$variable_code[2:3], endyear = 2015)

dc_carless <- list(dc_carless_2009, dc_carless_2010, dc_carless_2011, dc_carless_2012, dc_carless_2013, dc_carless_2014, dc_carless_2015)

dc_carless <- dc_carless %>% 
  lapply(function(x) {
    x %>% 
      filter(GEOID == '11') %>% 
      select(-(moe), -(NAME)) %>% 
      spread(variable, `estimate`)})

dc_carless <- do.call("rbind", dc_carless) %>% 
  mutate(Year = years,
         P_carless = B08201_002 / B08201_001 * 100)


#-----------------------------------------------------------------------------------------------------------------------------------
# Graphics

# X-axis labels
xaxis_names <-  c('20 to 30', '30 to 40', '40 to 50', 
              '50 to 60', '60 to 70', '70 to 80',
              '80 to 90', '90 to 100')

# Race color scheme and labels
racecol <- c("B02001_002" = "#527394", "B02001_003" = "#8BCFC5",
             "B02001_005" = "#D16D3B", "B03002_012" = "#B16379")
racedemo <- c("B02001_002" = "White", "B02001_003" = "African American",
              "B02001_005" = "Asian", "B03002_012" = "Hispanic")

# Houshold size color scheme and labels
housecol <- c("B08201_008" = "#527394", "B08201_014" = "#8BCFC5",
             "B08201_020" = "#D16D3B", "B08201_026" = "#B16379")
housedemo <- c("B08201_008" = "1 Person", "B08201_014" = "2 Person",
              "B08201_020" = "3 Person", "B08201_026" = "4+ Person")

# Race Barchart
ggplot(cfl_index_race, aes(Score_bin, race_prop, fill = race)) +
  geom_bar(stat = 'identity',position = 'dodge') +
  scale_fill_manual('Race', labels = racedemo, values = racecol) +
  scale_x_discrete(labels = xaxis_names) +
  scale_y_continuous(breaks = seq(0,100, by = 10), limits = c(0, 100)) +
  labs(x = "Car Free Livability Index", y = "Percent of Total Population",
       title = "Areas with greater car free livability are predominenty white",
       subtitle = "Racial percentage by car free livibility range",
       caption = "Source: ACS 2015") +
  theme_fivethirtyeight()

# House Size Barchart
ggplot(cfl_index_house, aes(Score_bin, house_prop, fill = house_size)) +
  geom_bar(stat = 'identity',position = 'dodge') +
  scale_fill_manual('Household Size', labels = housedemo, values = housecol) +
  scale_x_discrete(labels = xaxis_names) +
  scale_y_continuous(breaks = seq(0,100, by = 10), limits = c(0, 100)) +
  labs(x = "Car Free Livability Index", y = "Percent of Total Household Population",
       title = "Carless 4+ person households are not likely\nto live in car free havens",
       subtitle = "Carless household size by car free livability range",
       caption = "Source: ACS 2015") +
  theme_fivethirtyeight()

# Income Barchart
ggplot(cfl_index_income, aes(Score_bin, MHI)) +
  geom_bar(stat = 'identity', width = 0.8, fill = "#6D7D8C") +
  scale_x_discrete(labels = xaxis_names) +
  scale_y_continuous(labels = human_usd, breaks = seq(0,100000, by = 20000), limits = c(0,100000)) +
  labs(x = "Car Free Livability Index", y = "Median Household Income (USD)",
       title = "Areas with greater car free livability have\nhigher median household incomes",
       subtitle = "Median household income by car free livability range",
       caption = "Source: ACS 2015") +
  theme_fivethirtyeight()








