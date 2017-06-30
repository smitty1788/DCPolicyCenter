# Analysis of Building CO2 Emissions in Washington D.C.
# For: D.C. Policy Center
# Author: Randy Smith

library(tidyverse)
library(lubridate)

# Set working Directory
setwd("G:/DC Policy Center/Carbon Emmisions/Data")



# adding row for Howard University
howard <- tribble(
  ~PROPERTYNAME, ~REPORTINGYEAR, ~OWNEROFRECORD, ~REPORTEDADDRESS, ~YEARBUILT, ~PRIMARYPROPERTYTYPE_SELFSELECT, ~PRIMARYPROPERTYTYPE_EPACALC, ~TAXRECORDFLOORAREA, ~ENERGYSTARSCORE, ~TOTGHGEMISSIONS_METRICTONSCO2E, ~TOTGHGEMISSINTENSITY_KGCO2EFT, ~LATITUDE, ~LONGITUDE,
  'Howard University', 2014, 'Howard University', NA, NA, 'College/University', 'College/University', NA, NA, 43301, 30, -77.020382, 38.921833)

# Read in Data
emissions <- read.csv("https://raw.githubusercontent.com/smitty1788/DCPolicyCenter/master/May%202017/Building_Carbon_Emissions/Analysis/Building_Energy_Benchmarks.csv", 
                      stringsAsFactors = FALSE) %>% 
  filter(REPORTINGYEAR == 2014) %>%
  mutate(TOTGHGEMISSIONS_METRICTONSCO2E = as.numeric(TOTGHGEMISSIONS_METRICTONSCO2E),
         TOTGHGEMISSINTENSITY_KGCO2EFT = as.numeric(TOTGHGEMISSINTENSITY_KGCO2EFT)) %>% 
  rbind(howard)
write.csv(emissions, 'Tab/building_emissions.csv', row.names = FALSE)
  
  


#-------------------------------------------------------------------------------------------------------------------------
# Summarise CO2 emissions by type of building

# Reduce number of property types to 10. Rename as "Other" if not in the top ten for count
type <- emissions %>% 
  group_by(PRIMARYPROPERTYTYPE_EPACALC) %>% 
  count(PRIMARYPROPERTYTYPE_EPACALC) %>% 
  arrange(desc(n)) %>%  
  mutate(Property_Type = if_else(n < 6, "Other", PRIMARYPROPERTYTYPE_EPACALC),
         Property_Type = if_else(Property_Type == "Residence Hall/Dormitory", "Other", Property_Type))

# Table join new property types back to original table
emit <- emissions %>% 
  merge(y = type[ , c("PRIMARYPROPERTYTYPE_EPACALC", "Property_Type")], by = "PRIMARYPROPERTYTYPE_EPACALC", all.x = TRUE)


# summarise by type
type_summary <- emit %>% 
  group_by(Property_Type) %>% 
  summarise(Count = n(),
            AvgCO2Tons = mean(TOTGHGEMISSIONS_METRICTONSCO2E, na.rm = TRUE),
            AvgCO2KGSQFT = mean(TOTGHGEMISSINTENSITY_KGCO2EFT,na.rm = TRUE)) %>% 
  arrange(desc(AvgCO2Tons))

write.csv(type_summary, "Tab/Tidy/type_summary.csv", row.names = FALSE)

ggplot(type_summary, aes(x = Property_Type, y = AvgCO2Tons, fill = Property_Type)) +
  geom_bar(stat = "identity")
  ggtitle("Vroom") +
  scale_color_manual(values = pal("few_medium"))

  

#-------------------------------------------------------------------------------------------------------------------------
# Summarise CO2 emissions by year built
# Bin to 20 year intervals and summarise
built <- emissions %>% 
  filter(YEARBUILT >= 1860) %>% 
  mutate(year_bucket = cut(YEARBUILT, breaks = c(1860, 1880, 1900, 1920, 1940, 1960, 1980, 2000, 2020), right = FALSE)) %>% 
  group_by(year_bucket) %>% 
  summarise(count = n(),
            AvgCO2Tons = mean(TOTGHGEMISSIONS_METRICTONSCO2E, na.rm = TRUE),
            AvgCO2KGSQFT = mean(TOTGHGEMISSINTENSITY_KGCO2EFT, na.rm = TRUE)) %>% 
  arrange(desc(AvgCO2Tons))

write.csv(built, "Tab/Tidy/year_summary.csv", row.names = FALSE)

#-------------------------------------------------------------------------------------------------------------------------
# List of top properties for emissions

# Excluding GWU as they are calculate by building, will add in total sum for GWU below
top <- emissions %>% 
  filter(OWNEROFRECORD != "GEORGE WASHINGTON UNIVERSITY",
         OWNEROFRECORD != "GALLAUDET UNIVERSITY") %>%
  mutate(Property_Name = PROPERTYNAME,
         Metric_Tons_CO2 = as.numeric(TOTGHGEMISSIONS_METRICTONSCO2E),
         KGSQFT_CO2 = as.numeric(TOTGHGEMISSINTENSITY_KGCO2EFT)) %>% 
  select(OWNEROFRECORD, Property_Name:KGSQFT_CO2)

# Aggregating total sum for GWU and Galludet properties (Consistent with other Universities)
gwu <- emissions %>% 
  filter(OWNEROFRECORD == "GEORGE WASHINGTON UNIVERSITY") %>% 
  group_by(OWNEROFRECORD) %>% 
  summarise(Metric_Tons_CO2 = sum(TOTGHGEMISSIONS_METRICTONSCO2E, na.rm = TRUE), 
            KGSQFT_CO2 = sum(TOTGHGEMISSINTENSITY_KGCO2EFT, na.rm = TRUE)) %>% 
  mutate(PROPERTYNAME = "GEORGE WASHINGTON UNIVERSITY",
         Property_Name = PROPERTYNAME) %>% 
  select(OWNEROFRECORD, Property_Name, Metric_Tons_CO2, KGSQFT_CO2)

gall <- emissions %>% 
  filter(OWNEROFRECORD == "GALLAUDET UNIVERSITY") %>% 
  group_by(OWNEROFRECORD) %>% 
  summarise(Metric_Tons_CO2 = sum(TOTGHGEMISSIONS_METRICTONSCO2E, na.rm = TRUE), 
            KGSQFT_CO2 = sum(TOTGHGEMISSINTENSITY_KGCO2EFT, na.rm = TRUE)) %>% 
  mutate(PROPERTYNAME = "Gallaudet University",
         Property_Name = PROPERTYNAME) %>% 
  select(OWNEROFRECORD, Property_Name, Metric_Tons_CO2, KGSQFT_CO2)

# Binding GWU/Galludet back with original list
top <- top %>% 
  rbind(gwu, gall) %>% 
  arrange(desc(Metric_Tons_CO2))
top$Property_Name <- gsub("GEORGE WASHINGTON UNIVERSITY", "George Washington University", top$Property_Name)
write.csv(top, "Tab/Tidy/property_summary.csv", row.names = FALSE)

