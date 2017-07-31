# Shotspotter analysis for Washington D.C.
# For: D.C. Policy Center
# Author: Randy Smith


library(tidyverse)
library(tidycensus)
library(lubridate)
library(zoo)
library(sf)
library(rgdal)
source('G:/DC Policy Center/Handy Scripts/fivethirtyeight.r')
source('G:/DC Policy Center/Handy Scripts/human_units.r')

setwd('G:/DC Policy Center/Shotspotter')


#-----------------------------------------------------------------------------------------
# Read in Data
# Tidy Data to bind into one Dataframe

# Data from Mid-2013 to Mid-2017
ss_13_17 <- read.csv('Data/Tab/shotspotter_2013_2017.csv', stringsAsFactors = FALSE) %>% 
  mutate(TRIGGERTIME = ymd_hms(TRIGGERTIME))

# Data from 2006 to  Mid-2013
ss_06_13 <- read.csv('Data/Tab/shotspotter_2006_2013.csv', stringsAsFactors = FALSE) %>% 
  mutate(Date.Time = mdy_hm(Date.Time),
         Coverage.Area = substring(Coverage.Area, 13, nchar(Coverage.Area)),
         NUMSHOTS = NA) %>% 
  select(Coverage.Area, Date.Time, Type, NUMSHOTS, Latitude.100meter, Longitude.100meter) %>% 
  filter(Latitude.100meter > 1)

# Copy column names from ss_13_17 to ss_06_13
colnames(ss_06_13) <- colnames(ss_13_17)

# Combine
# Add new date variables
ss <- rbind(ss_13_17, ss_06_13) %>% 
  mutate(Year = year(TRIGGERTIME),
         Month = month(TRIGGERTIME),
         Day = wday(TRIGGERTIME, label = TRUE),
         Year_Month = as.Date(as.yearmon(TRIGGERTIME)))

# Final Cleaned Data to 
ss %>% select(-(Month:Year_Month)) %>% 
write.csv('Data/Tab/Tidy/shootspotter_DC.csv', row.names = FALSE, na = "")



#-----------------------------------------------------------------------------------------
# Aggregate Census Data

# Census Tracts and Neighborhood CLuster Shapes
tracts <- st_read('Data/Spatial/Census_Tracts/census_tracts.geojson', stringsAsFactors = FALSE)
nbh_cluster <- st_read('Data/Spatial/Neighborhood_Clusters/Neighborhood_Clusters.geojson', stringsAsFactors = FALSE)

# Census Key
census_api_key("8b5d3a4726e6bd0e6c47ab773476281d0e653fce")

# Variable to pull from Census
variables_df <- tibble(
  "varible_name" = c('Total', 'White', 'Black', 'Asian', 'Hispanic', 'MHI'),
  "variable_code" = c('B02001_001E', 'B02001_002E', 'B02001_003E', 'B02001_005E', 'B03003_003E', 'B19013_001E')
)


# Census Statistics for 2009 and 2015 aggregated to Neighborhood Cluster
demographics_2009 <- get_acs(geography = "tract", variables = variables_df$variable_code, state = 'DC', county = '001', endyear = 2009)  %>% 
  select(-(NAME), -(moe)) %>% 
  spread(variable, estimate) %>% 
  merge(tracts, by = 'GEOID') %>% 
  group_by(N_Name, N_Cluster) %>% 
  summarise(Total_2009 = sum(B02001_001, na.rm = TRUE),
            White_2009 = sum(B02001_002, na.rm = TRUE),
            Black_2009 = sum(B02001_003, na.rm = TRUE),
            MHI_2009 = round(mean(B19013_001, na.rm = TRUE), 2)) %>% 
  mutate(White_2009 = White_2009 / Total_2009 * 100,
         Black_2009 = Black_2009 / Total_2009 * 100) %>% 
  select(N_Name, N_Cluster, White_2009, Black_2009, MHI_2009)
  

demographics_2015 <- get_acs(geography = "tract", variables = variables_df$variable_code, state = 'DC', county = '001', endyear = 2015)  %>% 
  select(-(NAME), -(moe)) %>% 
  spread(variable, estimate) %>% 
  merge(tracts, by = 'GEOID') %>% 
  group_by(N_Name, N_Cluster) %>% 
  summarise(Total_2015 = sum(B02001_001, na.rm = TRUE),
            White_2015 = sum(B02001_002, na.rm = TRUE),
            Black_2015 = sum(B02001_003, na.rm = TRUE),
            MHI_2015 = round(mean(B19013_001, na.rm = TRUE), 2)) %>% 
  mutate(White_2015 = White_2015 / Total_2015 * 100,
         Black_2015 = Black_2015 / Total_2015 * 100) %>% 
  select(N_Name, N_Cluster, White_2015, Black_2015, MHI_2015)


#-----------------------------------------------------------------------------------------
# Shots per neighborhood

# Subset Longitude/Latitude
ss_2009 <- ss %>%
  filter(Year == 2009) %>% 
  select(LONGITUDE, LATITUDE)

ss_2016 <- ss %>%
  filter(Year == 2016) %>% 
  select(LONGITUDE, LATITUDE)

# read neighborhood GeoJSON file
hoods <- readOGR(dsn = "Data/Spatial/Neighborhood_Clusters/Neighborhood_Clusters.geojson", layer = "OGRGeoJSON")

# Add pickup/dropff points to Spatial points
ss_2009_points <- SpatialPoints(ss_2009, proj4string=CRS(as.character("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")))
ss_2016_points <- SpatialPoints(ss_2016, proj4string=CRS(as.character("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")))


# Perfom Spatial Join
ss_counts_2009 <- over(ss_2009_points, hoods) %>% 
  count(FIRST_N_Na, N_Cluster) %>% 
  rename(N_Name = FIRST_N_Na,
         Shots_2009 = n)

ss_counts_2016 <- over(ss_2016_points, hoods) %>% 
  count(FIRST_N_Na, N_Cluster) %>% 
  rename(N_Name = FIRST_N_Na,
         Shots_2016 = n) %>% 
  select(-(N_Cluster))

ss_change <- ss_counts_2009 %>% 
  merge(ss_counts_2016, by = 'N_Name') %>% 
  na.omit() %>% 
  mutate(Shots_Change = round((Shots_2016 - Shots_2009) / Shots_2009 * 100, 2))


#-----------------------------------------------------------------------------------------
# Demographic Change

# Calculate Demographic Changes
demo_change <- demographics_2009 %>% 
  merge(demographics_2015, by = 'N_Cluster') %>% 
  mutate(White_Change = round((White_2015 - White_2009) / White_2009 * 100, 2),
         Black_Change = round((Black_2015 - Black_2009) / Black_2009 * 100, 2),
         MHI_Change = round((MHI_2015 - MHI_2009) / MHI_2009 * 100, 2),
         White_Change = if_else(is.infinite(White_Change), -1 * Black_Change, White_Change)) %>%
  rename(N_Name = N_Name.x) %>% 
  select(N_Cluster, N_Name, MHI_Change, White_Change, Black_Change)

# Merge demographics with Shot data
ss_demo <- demo_change %>% 
  merge(ss_change, by = 'N_Cluster', all.x = TRUE) %>% 
  rename(N_Name = N_Name.x) %>% 
  merge(nbh_cluster, by = 'N_Cluster', all.x = TRUE) %>% 
  select(N_Cluster:Black_Change, Shots_2009:Shots_Change, geometry) %>% 
  st_as_sf()



# write to csv, geojson, and Shapefile file
write.csv(ss_demo, 'Data/Tab/TidyShotspotter_Change.csv', row.names = FALSE)
st_write(ss_demo, 'Data/Spatial/Web/Shotspotter_Change.geojson')
st_write(ss_demo, 'Data/Spatial/Web/Shotspotter_Change/Shotspotter_Change.shp')

#-----------------------------------------------------------------------------------------
# Shotspotter Trends

# Percent change since 2009
ss %>% 
  filter(between(Year, 2009, 2016)) %>% 
  count(Year) %>%
  mutate(n = (n - n[1]) / n[1] * 100) %>% 
  ggplot(aes(Year, n)) +
  geom_hline(yintercept = 0, color = '#B16379', size = 1) +
  annotate("text", 2009.8, 2.2, label = "2009 Baseline") +
  geom_point(color = '#527394', size = 2) +
  geom_line(color = '#527394', size = 1) +
  labs(x = "Year", y = "% Change in Gunshots Detected",
       title = "Gunshots detected have been on a decline since 2014",
       subtitle = "Percent change in gunshots detected by Shotspotter since 2009",
       caption = "Source: Metropolitan Police Department, 2017\n D.C. Policy Center | dcpolicycenter.org") +
  scale_x_continuous(breaks = seq(2009, 2016, by = 1), limits = c(2009, 2016)) +
  scale_y_continuous(breaks = seq(-50, 10, by = 10), limits = c(-50, 10)) +
  theme(plot.title = element_text(size = 18)) +
  theme_fivethirtyeight()


#-----------------------------------------------------------------------------------------
# Homicide Trends

# Homicide stats taken from https://mpdc.dc.gov/node/208772
homicide <- tribble(
  ~Year, ~Count,
  2009, 144,
  2010, 132,
  2011, 108,
  2012, 88,
  2013, 104,
  2014, 105,
  2015, 162,
  2016, 135
)

# Percent change since 2009
homicide %>% 
  mutate(Count = (Count - Count[1]) / Count[1] * 100) %>%
  ggplot(aes(Year, Count)) +
  geom_hline(yintercept = 0, color = '#B16379', size = 1) +
  annotate("text", 2009.8, 2.2, label = "2009 Baseline") +
  geom_point(color = '#527394', size = 2) +
  geom_line(color = '#527394', size = 1) +
  labs(x = "Year", y = "% Change in Homicides",
       title = "Homicides in Washington, D.C.",
       subtitle = "Percent change in homicides since 2009",
       caption = "Source: Metropolitan Police Department, 2017\n D.C. Policy Center | dcpolicycenter.org") +
  scale_x_continuous(breaks = seq(2009, 2016, by = 1), limits = c(2009, 2016)) +
  scale_y_continuous(breaks = seq(-40, 20, by = 10), limits = c(-40, 20)) +
  theme(plot.title = element_text(size = 18)) +
  theme_fivethirtyeight()

# Homicide and Gunshots compared
compare <- ss %>% 
  filter(between(Year, 2009, 2016)) %>% 
  count(Year) %>% 
  merge(homicide, by = 'Year') %>% 
  mutate(Count = (Count - Count[1]) / Count[1] * 100,
         n = (n - n[1]) / n[1] * 100) %>% 
  gather('Type', 'Estimate', `n`, `Count`)


# Graph colors and labels
group_colors <- c('Count' = '#527394',
                  'n' = '#BECCDA')
group_labels <- c('Count' = 'Homicide',
                  'n' = 'Gunshots')

ggplot(compare, aes(Year, Estimate, color = Type)) +
  geom_hline(yintercept = 0, color = '#B16379', size = 1) +
  annotate("text", 2009.8, 2.2, label = "2009 Baseline") +
  geom_point(size = 2) +
  geom_line(size = 1) +
  labs(x = "Year", y = "% Change",
       title = "Percent change in homicides compared\nto gunshots since 2009",
       caption = "Source: Metropolitan Police Department, 2017\n D.C. Policy Center | dcpolicycenter.org") +
  scale_x_continuous(breaks = seq(2009, 2016, by = 1), limits = c(2009, 2016)) +
  scale_y_continuous(breaks = seq(-45, 15, by = 10), limits = c(-45, 15)) +
  scale_color_manual('Legend', values = group_colors, labels = group_labels) +
  theme(plot.title = element_text(size = 18)) +
  theme_fivethirtyeight()


#-----------------------------------------------------------------------------------------
# Guncrime Trends

# URLs for crime incident csv files availible at opendata.dc.gov
urls <- c('https://opendata.arcgis.com/datasets/73cd2f2858714cd1a7e2859f8e6e4de4_33.csv',
          'https://opendata.arcgis.com/datasets/fdacfbdda7654e06a161352247d3a2f0_34.csv',
          'https://opendata.arcgis.com/datasets/9d5485ffae914c5f97047a7dd86e115b_35.csv',
          'https://opendata.arcgis.com/datasets/010ac88c55b1409bb67c9270c8fc18b5_11.csv',
          'https://opendata.arcgis.com/datasets/5fa2e43557f7484d89aac9e1e76158c9_10.csv',
          'https://opendata.arcgis.com/datasets/6eaf3e9713de44d3aa103622d51053b5_9.csv',
          'https://opendata.arcgis.com/datasets/35034fcb3b36499c84c94c069ab1a966_27.csv',
          'https://opendata.arcgis.com/datasets/bda20763840448b58f8383bae800a843_26.csv'
)

# Read in data from URLs
for (i in 1:length(urls)) {
  
  assign(paste0("mycsv_",i), read.csv(url(urls[i]), header = T) %>% 
           mutate(Date = ymd_hms(REPORT_DAT),
                  Year = year(Date)) %>% 
           select(Date, Year, METHOD)) 
}

# Bind all csvs
# Filter gun crimes
# Count by year
gun_crime <- rbind(mycsv_1, mycsv_2, mycsv_3, mycsv_4, 
                   mycsv_5, mycsv_6, mycsv_7, mycsv_8) %>% 
  filter(METHOD == 'GUN') %>% 
  count(Year) %>% 
  rename(Gun_crime = n)

# Proportion of reported gun crime to detected gunshots
gun_crime_shots <- ss %>% 
  filter(between(Year, 2009, 2016)) %>% 
  count(Year) %>% 
  merge(gun_crime, by = 'Year') %>% 
  mutate(Percent = Gun_crime / n * 100)

ggplot(gun_crime_shots, aes(Year, Percent)) +
  geom_point(size = 2, color = '#527394') +
  geom_line(size = 1, color = '#527394') +
  labs(x = "Year", y = "% of gun crime\nto detected gunshots",
       title = "Proportion of reported gun crime to\ndetected gunshots in Washington, D.C.",
       caption = "Source: Metropolitan Police Department, 2017\n D.C. Policy Center | dcpolicycenter.org") +
  scale_x_continuous(breaks = seq(2009, 2016, by = 1), limits = c(2009, 2016)) +
  scale_y_continuous(breaks = seq(0, 50, by = 10), limits = c(0, 50)) +
  theme(plot.title = element_text(size = 18)) +
  theme_fivethirtyeight()


#-----------------------------------------------------------------------------------------
# Shotspotter Purchase Orders

# URLs to purchase order csv. Can be found at http://opendata.dc.gov/datasets?q=purchase%20orders
purchase_urls <- c('FY2017' = 'https://opendata.arcgis.com/datasets/829f617627114ca1b6ee6c99acc7d11c_48.csv',
                   'FY2016' = 'https://opendata.arcgis.com/datasets/aa91227baed140c98cfcf91a8c96263a_47.csv',
                   'FY2015' = 'https://opendata.arcgis.com/datasets/a3db68903a65496998ca388cb82ba926_46.csv',
                   'FY2014' = 'https://opendata.arcgis.com/datasets/97f7e986ae24450e8c62b1903330d88f_45.csv',
                   'FY2013' = 'https://opendata.arcgis.com/datasets/bb847c6714ff4f10a87f0ba9db47f497_44.csv',
                   'FY2012' = 'https://opendata.arcgis.com/datasets/77f88dda8b2e492eb0e03994649cd8e9_49.csv',
                   'FY2011' = 'https://opendata.arcgis.com/datasets/9c08e5e0c7194b3da30f73251f97d79b_43.csv',
                   'FY2010' = 'https://opendata.arcgis.com/datasets/5c102edbf98742219f64741b444957d2_42.csv',
                   'FY2009' = 'https://opendata.arcgis.com/datasets/530f3bc67701490d81b49e2d639fe303_41.csv',
                   'FY2008' = 'https://opendata.arcgis.com/datasets/d4aa06a4a82f4a899ebe16af1347f37e_40.csv')

# Read in data
purchase_orders <- lapply(purchase_urls, read.csv, stringsAsFactors = FALSE)

# Consolidate into one dataframe
# Filter by supplier
# Summarise by year
shotspotter_cost <- as.data.frame(do.call(rbind, purchase_orders)) %>% 
  filter(stringr::str_detect(SUPPLIER, 'SHOT')) %>% 
  group_by(FISCAL_YEAR) %>% 
  summarise(Cost = round(sum(PO_TOTAL_AMOUNT, na.rm = TRUE), 2))

# Shotspotter cost per year
ggplot(shotspotter_cost, aes(FISCAL_YEAR, Cost)) +
  geom_point(size = 2, color = '#527394') +
  geom_line(size = 1, color = '#527394') +
  labs(x = "Fiscal Year", y = "Cost (USD)",
       title = "Since 2013, Shootspotter has cost D.C.\nan average of $450k per year",
       subtitle = "Cost of Shotspotter services per fiscal year",
       caption = "   Source: DCOCP, 2017\nD.C. Policy Center | dcpolicycenter.org") +
  scale_x_continuous(breaks = seq(2008, 2017, by = 1), limits = c(2008, 2017)) +
  scale_y_continuous(breaks = seq(0, 1750000, by = 250000), limits = c(0, 1750000), labels = human_usd) +
  theme(plot.title = element_text(size = 18)) +
  theme_fivethirtyeight()
