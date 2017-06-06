library(tidyverse)
library(lubridate)
library(stringr)
library(rgdal)

# Set working directory
setwd('G:/DC Policy Center/Carbon_Sequestration/Data')

# Read in Data
trees <- read.csv('Tab/Trees.csv', stringsAsFactors = FALSE) %>% 
  mutate(DATE_PLANT = as.POSIXct(DATE_PLANT, format = "%Y-%m-%d"),
         CONDITIODT = as.POSIXct(CONDITIODT, format = "%Y-%m-%d"),
         LAST_EDI_1 = as.POSIXct(LAST_EDI_1, format = "%Y-%m-%d"))
coef <- read.csv('Tab/green_weight_coef.csv', stringsAsFactors = FALSE)


# Assigning categories 
# Joining coeficients
tree <- trees %>% 
  mutate(category = if_else(str_detect(CMMN_NM, "oak"), "Oak",
                if_else(str_detect(CMMN_NM, "gum"), "Sweetgum",
                if_else(str_detect(TREE_NOTES, "gum"), "Blackgum",
                if_else(str_detect(CMMN_NM, "poplar"), "Tulip Poplar",
                if_else(str_detect(CMMN_NM, "tupelo"), "Tupelo",
                if_else(str_detect(CMMN_NM, "ash"), "Ash",
                if_else(str_detect(CMMN_NM, "maple"), "Maple",
                if_else(str_detect(CMMN_NM, "hickory"), "Hickory", "All"))))))))) %>% 
  merge(y = coef, by = "category", all.x = TRUE)

# co2 sequestration----------------------------------------------------
# Calculating CO2 Sequestration per year

carbon_sequest <- function(x){
  green_weight_roots <- x * 1.2
  dry_weight <- green_weight_roots * .725
  total_carbon <- dry_weight * .5
  (total_carbon * 3.6663)
}

c02_sequest <- tree %>%
  rename(Height = RASTERVALU) %>% 
  mutate(DBH = if_else(DBH <= 2, 2,
                       if_else(DBH >= 99, DBH / 10, DBH)),
         Heightft = Height * 3.28084,
         green_weight = if_else(category != "All" & DBH < 11, a_11 * (DBH ^ 2) * b_11, #Depending on category, uses different coeficients and formula to calculate green weight
                if_else(category != "All" & DBH >= 11, a_11plus * (DBH ^ 2) * b_11plus,
                  if_else(category == "All" & DBH < 11, x_11 * (DBH ^ 2) * Heightft,
                      x_11plus * (DBH ^ 2) * Heightft))),
         co2_sequest = carbon_sequest(green_weight),
         kwh_year = (82.979 * DBH) - 125.65,
         kwh_savings = kwh_year * 0.0793,
         stormwater_filtered = 117.12 * DBH) %>% 
  select(Long, Lat, category, OBJECTID,DATE_PLANT, WARD,
         CMMN_NM, SCI_NM, GENUS_NAME, FAM_NAME,
         DBH, Height, Heightft, a_11:x_11plus,
         green_weight, co2_sequest, kwh_year, kwh_savings, stormwater_filtered)


DC_Street_Trees <- c02_sequest %>% 
  mutate(CMMN_NM = if_else(CMMN_NM %in% c(" ", "Other (See Notes)"), "Other/Unknown", CMMN_NM),
         co2_sequest = round(co2_sequest, digits = 2), 
         kwh_year = round(kwh_year, digits = 2), 
         kwh_savings = round(kwh_savings, digits = 2), 
         stormwater_filtered = round(stormwater_filtered, digits = 2),
         Heightft = round(Heightft, digits = 0)) %>% 
  select(Long, Lat, CMMN_NM, DBH, Heightft,
         co2_sequest, kwh_year, kwh_savings, stormwater_filtered)

treecount <- DC_Street_Trees %>% 
  count(CMMN_NM)

# Write final data to csv
write.csv(c02_sequest, "Tab/Tidy/c02_sequest.csv", row.names = FALSE)

# Write csv for Carto
write.csv(DC_Street_Trees, "Tab/Tidy/DC_Street_Trees.csv", row.names = FALSE)

# -------------------------------------------------------------------------------------------------------------------------
# Summarise key tree statistics by neighborhood cluster

# Select Long?lat
tree_loc <- c02_sequest %>% 
  select(Long, Lat)

# Read GeoJSON file
hood <- readOGR(dsn = "G:/DC Policy Center/Carbon_Sequestration/Data/Spatial/DC Neighborhood Clusters.geojson", layer = "OGRGeoJSON")

# Add trees to Spatial points
Trees <- SpatialPoints(tree_loc, proj4string=CRS(as.character("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")))

# Perfom Spatial Join
Trees_NHood <- over(Trees, hood) %>% 
  select(-(OBJECTID))

# Table join with original dataframe
CO2_NHOOD <- cbind(c02_sequest, Trees_NHood) %>% 
  select(-(WEB_URL), -(SHAPE_Leng:SHAPE_Area))

# Summary by neighborhood
CO2_NHOOD_Sum <- CO2_NHOOD %>% 
  group_by(NBH_NAMES, NAME) %>% 
  summarise(Trees = n(),
            co2_sequestered = sum(co2_sequest),
            kwh_year = sum(kwh_year),
            kwh_savings = sum(kwh_savings),
            stormwater_filtered = sum(stormwater_filtered)) %>% 
  arrange(desc(kwh_savings)) %>% 
  na.omit()

# Write final data to csv
write.csv(CO2_NHOOD_Sum, "Tab/Tidy/co2_nhood_summary.csv", row.names = FALSE)


