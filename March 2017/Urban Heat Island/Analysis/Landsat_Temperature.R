library(raster)
library(tidyverse)
library(SciViews)
library(rgdal)

setwd('G:/DC Policy Center/Urban Heat Island')

# Read in Raster Data
Band_10 <- raster('Data/Spatial Data/Imagery/LC08_L1TP_015033_20150817_20170226_01_T1/LC08_L1TP_015033_20150817_20170226_01_T1_B10.tif')
Band_11 <- raster("Data/Spatial Data/Imagery/LC08_L1TP_015033_20150817_20170226_01_T1/LC08_L1TP_015033_20150817_20170226_01_T1_B11.tif")

# Read in DC Shapefile
DC <- readOGR('Data/Spatial Data/DC_Census_Tracts/DC_Census_Tracts.shp')
DC <- spTransform(DC, CRS("+proj=utm +zone=18 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0"))

# Calculates temperature using Bands 10 and 11
landsat_temp <- function(Band_10, Band_11){
  
  radiance <- function(x){
    (0.0003342 * x + 0.1)
  }
  
  b10_temp <- function(x) {
    1321.08 / (SciViews::ln(744.89 / x + 1)) - 272.15 
  }
  
  b11_temp <- function(x) {
    1201.14 / (SciViews::ln(480.89 / x + 1)) - 272.15 
  }
  
  B10_Rad <- raster::calc(Band_10, radiance)
  B11_Rad <- raster::calc(Band_11, radiance)
  
  B10_Temp <- raster::calc(B10_Rad, b10_temp)
  B11_Temp <- raster::calc(B11_Rad, b11_temp) 
  
  Temp_Stack <- raster::stack(B10_Temp, B11_Temp)
  
  mean(Temp_Stack, na.rm = TRUE)
}


# Calculating Surface Temperature 
Temperature <- landsat_temp(Band_10, Band_11)

# Clipping Raster to DC Borders
DC_Temperature <- mask(crop(Temperature, DC), DC)

# Write raster to geotiff
writeRaster(DC_Temperature, filename="Data/Spatial Data/Imagery/LC08_L1TP_015033_20150817_20170226_01_T1/DC_Temp.tif", 
            format="GTiff", overwrite=TRUE)
