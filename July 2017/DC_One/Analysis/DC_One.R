library(rgdal)
library(lubridate)
library(sf)
library(sp)
library(RQGIS) # Must have QGIS installed on machine
library(tidyverse)

# Set to your working drive
setwd('G://DC Policy Center/DC_One')
set_env()

#--------------------------------------------------------------------------------------------------------------------------
# QGIS Functions

# Clip Function
qgis_clip <- function(input, overlay, output) {
  param <- get_usage(alg = "qgis:clip")
  
  param$INPUT  <- input
  param$OVERLAY <- overlay
  param$OUTPUT <- output
  
  clip <- run_qgis(alg = "qgis:clip",
                   params = param,
                   load_output = TRUE)
}

# Vorionoi Polygon Functions
qgis_voronoipolygons <- function(input, output, buffer = 0) {
  
  param <- RQGIS::get_args_man("qgis:voronoipolygons")
  
  param$INPUT <- input
  param$BUFFER <- buffer
  param$OUTPUT <- output
  
  
  voronoipolygons <- RQGIS::run_qgis(alg = "qgis:voronoipolygons",
                                     params = param, load_output = TRUE)
}

# Fixed distance buffer
qgis_fixeddistancebuffer <- function(input, output, distance, segments = 5, dissolve = FALSE) {
  
  param <- RQGIS::get_args_man('qgis:fixeddistancebuffer')
  
  param$INPUT <- input
  param$OUTPUT <- output
  param$DISTANCE <- distance
  param$SEGMENTS <- segments
  param$DISSOLVE <- dissolve
  
  fixeddistancebuffer <- RQGIS::run_qgis(alg = 'qgis:fixeddistancebuffer',
                                         params = param,
                                         load_output = TRUE)
}

#--------------------------------------------------------------------------------------------------------------------------
# Read in Data
# Formating and Combining datasets

# Read in Data
# Clean
# Convert Wide to Long format
student_rail <- readxl::read_xlsx('Data/Tab/DC Student rail ridership by month and hour weekday only.xlsx',
                                  skip = 5) %>% 
  rename(Date = X__1,
         Station = X__2) %>%
  fill(Date) %>% 
  filter(!is.na(Station)) %>% 
  gather('Hour', 'Count', `4`:`3`) %>% 
  mutate(Hour = as.numeric(Hour),
         Date = ymd(stringr::str_c(Date, "01", sep = "")))

# Read in Data
# Clean
# Convert Wide to Long format
student_bus <- readxl::read_xlsx('Data/Tab/DC Student bus ridership by month and hour weekday only.xlsx',
                          skip = 5,
                          na = "NULL") %>% 
  rename(Date = X__1,
         Line = X__2) %>%
  fill(Date) %>% 
  filter(Date != 'Sum') %>% 
  gather('Hour', 'Count', `4`:`3`) %>% 
  mutate(Hour = as.numeric(Hour),
         Date = ymd(stringr::str_c(Date, "01", sep = "")))


student_busstops_2016_10 <- readxl::read_xlsx('Data/Tab/DC Student ridership by stop and hour 2016 10.xlsx',
                                      sheet = 'Sheet2', 
                                      skip = 2) %>%  
  gather('Hour', 'Count', `4`:`3`) %>%
  mutate(Hour = as.numeric(Hour),
         Date = as.Date('2016-10-01')) %>% 
  select(-(`Grand Total`)) %>% 
  filter(Route != "TEST")

student_busstops_2017_05 <- readxl::read_xlsx('Data/Tab/DC Student ridership by stop and hour 2017 05.xlsx',
                                              sheet = 'Summary', 
                                              skip = 2) %>%  
  gather('Hour', 'Count', `4`:`3`) %>%
  mutate(Hour = as.numeric(Hour),
         Date = as.Date('2017-05-01')) %>% 
  select(-(`Grand Total`))

student_busstops <- rbind(student_busstops_2016_10, student_busstops_2017_05)

# Spatial Data  
# Read in Spatial Data
metrorail_stations <- read_sf('Data/Spatial/Metro_GIS_shapefiles/Metrorail_stations.shp', stringsAsFactors = FALSE)

metrobus_stops <- read_sf('Data/Spatial/Metro_GIS_shapefiles/Metrobus_stops.shp', stringsAsFactors = FALSE)

metrobus_routes <- read_sf('Data/Spatial/Metro_GIS_shapefiles/Metrobus_routes.shp', stringsAsFactors = FALSE) %>% 
  filter(stringr::str_detect(BPLN_SEC_1, 'DC'))

#--------------------------------------------------------------------------------------------------------------------------
# Creating FIDs to address differences in spelling for Metro Station Names across datasets

# FID Creation
stations <- tibble(
  Station_A = sort(unique(student_rail$Station)),
  Station_B = sort(unique(metrorail_stations$NAME_SHORT)),
  FID = 1:91)

# Assinging FIDs to datasets
student_rail <- student_rail %>% 
  merge(stations, by.x = 'Station', by.y = 'Station_A') %>% 
  select(-(Station_B))

metrorail_stations <- metrorail_stations %>% 
  merge(stations, by.x = 'NAME_SHORT', by.y = 'Station_B') %>% 
  select(-(Station_A))


#--------------------------------------------------------------------------------------------------------------------------
# After School Statistics
# Time window of 1500 to 1900

# Non Summer months
school_months <- c(1:5,9:12)

# Work days per month
# Sourced from http://controller.berkeley.edu/payroll/payroll-system-pps/pps-training-materials/number-working-hours-month
work_days <- tibble(
  Month = sort(unique(student_rail$Date)),
  Work_days = c(22, 21, 23, 22, 21, 22, 22, 22, 20, 23, 20, 23, 22, 21)
)

# Average daily rail usage between 1500-1900 hours by station
rail_evening <- student_rail %>% 
  mutate(Month = month(Date)) %>% 
  filter(between(Hour, 15, 18),
         Month %in% school_months) %>%
  group_by(FID, Station, Date, Hour) %>% 
  summarise(obs = n(),
            count = sum(Count, na.rm = TRUE)) %>%
  merge(work_days, by.x = 'Date', by.y = "Month") %>% 
  mutate(Avg_Evening_Count = round(count / Work_days, 2),
         Hour = paste0('HR_',Hour)) %>%
  select(FID, Station, Hour, Avg_Evening_Count) %>%
  group_by(FID, Station, Hour) %>% 
  summarise(Avg_Evening_Count = sum(Avg_Evening_Count, na.rm = TRUE)) %>% 
  spread(Hour, Avg_Evening_Count) %>% 
  mutate(Avg_Evening_Count = HR_15 + HR_16, HR_17, HR_18)

# Average daily bus usage between 1500-1900 hours by bus stop
# Data from 2016-10 seems unreliable at best
# Using only data from 2017-05
bus_evening <- student_busstops_2017_05 %>% 
  mutate(Month = month(Date)) %>% 
  filter(between(Hour, 15, 18),
         Month %in% school_months) %>%
  rename(REG_ID = `Regional ID`) %>% 
  group_by(STOP_POINT_ID, REG_ID, Hour) %>% 
  summarise(obs = n(),
            count = sum(Count, na.rm = TRUE)) %>% 
  mutate(Avg_Evening_Count = round(count / 23, 2),
         Hour = paste0('HR_',Hour)) %>% 
  select(STOP_POINT_ID, REG_ID, Hour, Avg_Evening_Count) %>% 
  spread(Hour, Avg_Evening_Count) %>% 
  mutate(Avg_Evening_Count = HR_15 + HR_16, HR_17, HR_18)
  
# Vector used in DC bus line filter
DC_buslines <- sort(unique(metrobus_routes$ROUTE))

# Average daily bus usage between 1500-1900 hours by bus line
bus_line_evening <- student_bus %>% 
  mutate(Month = month(Date)) %>% 
  filter(between(Hour, 15, 18),
         Month %in% school_months,
         Line %in% DC_buslines) %>%
  group_by(Line, Date, Hour) %>% 
  summarise(obs = n(),
            count = sum(Count, na.rm = TRUE)) %>%
  merge(work_days, by.x = 'Date', by.y = "Month") %>% 
  mutate(Avg_Evening_Count = round(count / Work_days, 2),
         Hour = paste0('HR_',Hour)) %>% 
  group_by(Line, Hour) %>% 
  summarise(Avg_Evening_Count = round(mean(Avg_Evening_Count, na.rm = TRUE), 2)) %>% 
  spread(Hour, Avg_Evening_Count) %>% 
  mutate(Avg_Evening_Count = HR_15 + HR_16, HR_17, HR_18)

#--------------------------------------------------------------------------------------------------------------------------
# Before School Statistics
# Time window of 600 to 900

# Average daily rail usage between 600-900 hours by station
rail_morning <- student_rail %>% 
  mutate(Month = month(Date)) %>% 
  filter(between(Hour, 6, 8),
         Month %in% school_months) %>%
  group_by(FID, Station, Date, Hour) %>% 
  summarise(obs = n(),
            count = sum(Count, na.rm = TRUE)) %>%
  merge(work_days, by.x = 'Date', by.y = "Month") %>% 
  mutate(Avg_Morn_Count = round(count / Work_days, 2),
         Hour = paste0('HR_',Hour)) %>%
  select(FID, Station, Hour, Avg_Morn_Count) %>%
  group_by(FID, Station) %>% 
  summarise(Avg_Morn_Count = sum(Avg_Morn_Count, na.rm = TRUE))

# Average daily bus usage between 600-900 hours by bus stop
# Data from 2016-10 seems unreliable at best
# Using only data from 2017-05
bus_morning <- student_busstops_2017_05 %>% 
  mutate(Month = month(Date)) %>% 
  filter(between(Hour, 6, 8),
         Month %in% school_months) %>%
  rename(REG_ID = `Regional ID`) %>% 
  group_by(STOP_POINT_ID, REG_ID) %>% 
  summarise(obs = n(),
            count = sum(Count, na.rm = TRUE)) %>% 
  mutate(Avg_Morn_Count = round(count / 23, 2)) %>% 
  select(-(obs:count))


# Average daily bus usage between 600-900 hours by bus line
bus_line_morning <- student_bus %>% 
  mutate(Month = month(Date)) %>% 
  filter(between(Hour, 6, 8),
         Month %in% school_months,
         Line %in% DC_buslines) %>%
  group_by(Line, Date) %>% 
  summarise(obs = n(),
            count = sum(Count, na.rm = TRUE)) %>%
  merge(work_days, by.x = 'Date', by.y = "Month") %>% 
  mutate(Avg_Morn_Count = round(count / Work_days, 2)) %>% 
  group_by(Line) %>% 
  summarise(Avg_Morn_Count = round(mean(Avg_Morn_Count, na.rm = TRUE), 2))

#--------------------------------------------------------------------------------------------------------------------------
# Combine Morning and afternoon counts into one dataframe

rail_counts <- merge.data.frame(x = rail_evening, y = rail_morning, by = c('FID', 'Station'))

busstop_counts <- merge.data.frame(x = bus_evening, y = bus_morning, by = c('STOP_POINT_ID', 'REG_ID'))

busline_counts <- merge.data.frame(x = bus_line_evening, y = bus_line_morning, by = 'Line')


#--------------------------------------------------------------------------------------------------------------------------
# Write Afternoon Data to geojson for Carto

# Coordinate Reference System
WGS84 <- '+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0'


# Metrorail Stations
metrorail_stations %>% 
  merge(rail_counts, by = 'FID', all.x = TRUE) %>% 
  select(FID, Station, HR_15:Avg_Morn_Count, geometry) %>% 
  st_transform(4326) %>% 
  write_sf('Data/Spatial/Metro_GIS_shapefiles/Metro_Stations.geojson', delete_dsn = TRUE)

# Metrobus Stops
# Clip bustops outside of D.C. borders
metrobus_stops %>% 
  merge(busstop_counts, by = 'REG_ID', all.x = TRUE) %>% 
  select(REG_ID, HR_15:Avg_Morn_Count, geometry) %>% 
  st_transform(4326) %>%
  write_sf('Data/Spatial/Metro_GIS_shapefiles/Metrobus_Stops.geojson', delete_dsn = TRUE)


dc_busstops_clip <- qgis_clip('Data/Spatial/Metro_GIS_shapefiles/Metrobus_Stops.geojson',
                              'Data/Spatial/Metro_GIS_shapefiles/dc.geojson',
                              'Data/Spatial/Metro_GIS_shapefiles/DC_One_Metrobus_Stops.geojson')

dc_rail_clip <- qgis_clip('Data/Spatial/Metro_GIS_shapefiles/Metro_Stations.geojson',
                              'Data/Spatial/Metro_GIS_shapefiles/dc.geojson',
                              'Data/Spatial/Metro_GIS_shapefiles/DC_One_Metro_Stations.geojson')

# Metrobus Routes
metrobus_routes %>% 
  merge(busline_counts, by.x = 'ROUTE', by.y = 'Line', all.x = TRUE) %>% 
  select(ROUTE, HR_15:Avg_Morn_Count, geometry) %>% 
  distinct(ROUTE, .keep_all = TRUE) %>% 
  st_transform(4326) %>%
  write_sf('Data/Spatial/Metro_GIS_shapefiles/Metrobus_Routes.geojson', delete_dsn = TRUE)
  



# Read in busstop geojson
dc_busstops_clip <- read_sf('Data/Spatial/Metro_GIS_shapefiles/DC_One_Metrobus_Stops.geojson', stringsAsFactors = FALSE) %>% 
  rename(NAME = REG_ID)
stops <- as(dc_busstops_clip, "Spatial")
proj4string(stops) <- CRS(as.character(WGS84))

# Read in metro station geojson
# Drop Z coordinate to allow to use of QGIS vector tools
dc_stations <- read_sf('Data/Spatial/Metro_GIS_shapefiles/DC_One_Metro_Stations.geojson', stringsAsFactors = FALSE) %>% 
  select(-(FID)) %>% 
  rename(NAME = Station)

dc_stations_coords <- do.call(rbind, st_geometry(dc_stations)) %>% 
  as_tibble() %>% setNames(c("lon","lat"))

dc_stations <- dc_stations %>% 
  as.data.frame() %>% 
  select(-(geometry)) %>% 
  cbind(dc_stations_coords) %>% 
  select(NAME:lat) %>% 
  st_as_sf(coords = c("lon", "lat"), crs = 4326)
stations <- as(dc_stations, "Spatial")
proj4string(stations) <- CRS(as.character(WGS84))

# Metro Station Catchment Areas
station_catchment <- qgis_fixeddistancebuffer(input = dc_stations,
                                          output = 'Data/Spatial/Metro_GIS_shapefiles/station_catchment.geojson',
                                          distance = 0.009) %>% 
  merge.data.frame(y = dc_stations, by = 'NAME') %>% 
  select(NAME:HR_18.x, Avg_Evening_Count, Avg_Morn_Count, geometry.x)

colnames(station_catchment) <- c('NAME', 'HR_15', 'HR_16', 'HR_17', 'HR_18', 
                                 'Avg_Evening_Count', 'Avg_Morn_Count', 'geometry') 

station_catchment <- station_catchment %>% 
  st_as_sf() %>%
  write_sf('Data/Spatial/Metro_GIS_shapefiles/station_catchment.geojson', delete_dsn = TRUE)
catchment_stations <- readOGR('Data/Spatial/Metro_GIS_shapefiles/station_catchment.geojson')
proj4string(catchment_stations) <- CRS(as.character(WGS84))




# Read in school geojson file
public_schools <- read_sf('Data/Spatial/Schools/Public_Schools.geojson', stringsAsFactors = FALSE) %>% 
  filter(LEVEL_ %in% c('ES', 'HS', 'MS')) %>% 
  select(NAME)
charter_schools <- read_sf('Data/Spatial/Schools/Charter_Schools.shp', stringsAsFactors = FALSE) %>% 
  select(NAME)
enrollment <- read.csv('Data/Tab/Enrollment.csv', stringsAsFactors = FALSE)

school <- rbind(public_schools, charter_schools) %>% 
  merge(enrollment, by = 'NAME')

schools <- as(school, "Spatial")
proj4string(schools) <- CRS(as.character(WGS84))


# Define Catchment Areas
school_catchment <- qgis_voronoipolygons(input = schools,
                                           output = 'Data/Spatial/Metro_GIS_shapefiles/catchment.geojson',
                                           buffer = 10)


catchment_clip <- qgis_clip('Data/Spatial/Metro_GIS_shapefiles/catchment.geojson',
                            'Data/Spatial/Metro_GIS_shapefiles/dc.geojson',
                            'Data/Spatial/Metro_GIS_shapefiles/catchment_clip.geojson')


# Spatial join
school_catchment <- readOGR('Data/Spatial/Metro_GIS_shapefiles/catchment_clip.geojson', p4s = as.character(WGS84))


stop_schools <- over(stops, school_catchment) %>% 
  select(NAME, Enrollment) %>%
  rename(School = NAME) %>% cbind(as.data.frame(dc_busstops_clip)) %>% 
  select(School, HR_15:Avg_Evening_Count) %>% 
  rename(NAME = School)
  

station_schools <- over(schools, catchment_stations) %>%
  rename(Station = NAME) %>% 
  cbind(as.data.frame(schools)) %>% 
  group_by(Station) %>% 
  mutate(HR_15 = round((Enrollment / sum(Enrollment)) * HR_15, 2),
         HR_16 = round((Enrollment / sum(Enrollment)) * HR_16, 2),
         HR_17 = round((Enrollment / sum(Enrollment)) * HR_17, 2),
         HR_18 = round((Enrollment / sum(Enrollment)) * HR_18, 2),
         Avg_Evening_Count = round((Enrollment / sum(Enrollment)) * Avg_Evening_Count, 2)) %>%
  ungroup() %>% 
  select(NAME, HR_15:Avg_Evening_Count)

# Aggregate values per school
school_counts <- rbind(stop_schools, station_schools)  %>% 
  group_by(NAME) %>% 
  summarise(HR_15 = sum(HR_15, na.rm = TRUE),
            HR_16 = sum(HR_16, na.rm = TRUE),
            HR_17 = sum(HR_17, na.rm = TRUE),
            HR_18 = sum(HR_18, na.rm = TRUE),
            Avg_Evening_Count = sum(Avg_Evening_Count, na.rm = TRUE)) %>%
  merge(schools, by = 'NAME') %>% 
  select(NAME, HR_15:Avg_Evening_Count, Enrollment, coords.x1, coords.x2) %>% 
  st_as_sf(coords = c("coords.x1", "coords.x2"), crs = 4326) %>% 
  mutate(Enroll_Percent = round(Avg_Evening_Count / Enrollment * 100, 2),
         HR_15 = if_else(Avg_Evening_Count > Enrollment, round(HR_15 * 0.2, 2), HR_15), # 0.2 is Average student ridership rate
         HR_16 = if_else(Avg_Evening_Count > Enrollment, round(HR_16 * 0.2, 2), HR_16),
         HR_17 = if_else(Avg_Evening_Count > Enrollment, round(HR_17 * 0.2, 2), HR_17),
         HR_18 = if_else(Avg_Evening_Count > Enrollment, round(HR_18 * 0.2, 2), HR_18),
         Avg_Evening_Count = if_else(Avg_Evening_Count > Enrollment, round(Avg_Evening_Count * 0.2, 2), Avg_Evening_Count),
         Enroll_Percent = round(Avg_Evening_Count / Enrollment * 100, 2))
write_sf(school_counts, 'Data/Spatial/Metro_GIS_shapefiles/DC_One_school_counts.geojson', delete_dsn = TRUE)


