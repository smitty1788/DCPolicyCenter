# Analysis of Building CO2 Emissions in Washington D.C.
# For: D.C. Policy Center
# Author: Randy Smith

library(tidyverse)
library(gridExtra)
library(grid)

# Set working Directory
setwd("G:/DC Policy Center/Carbon Emmisions/Data")

# Read in Data
emissions <- read_csv("Tab/emissions.csv")


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
            AvgCO2Tons = mean(TOTGHGEMISSIONS_METRICTONSCO2E),
            AvgCO2KGSQFT = mean(TOTGHGEMISSINTENSITY_KGCO2EFT)) %>% 
  arrange(desc(AvgCO2Tons))

write.csv(type_summary, "Tab/Tidy/type_summary.csv", row.names = FALSE)

ggplot(type_summary, aes(x = Property_Type, y = AvgCO2Tons, fill = Property_Type)) +
  geom_bar(stat = "identity") +
  theme_ft() +
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
            AvgCO2Tons = mean(TOTGHGEMISSIONS_METRICTONSCO2E),
            AvgCO2KGSQFT = mean(TOTGHGEMISSINTENSITY_KGCO2EFT)) %>% 
  arrange(desc(AvgCO2Tons))

write.csv(built, "Tab/Tidy/year_summary.csv", row.names = FALSE)

#-------------------------------------------------------------------------------------------------------------------------
# List of top properties for emissions

# Excluding GWU as they are calculate by building, will add in total sum for GWU below
top <- emissions %>% 
  filter(OWNERNAME != "GEORGE WASHINGTON UNIVERSITY",
         OWNERNAME != "GALLAUDET UNIVERSITY") %>% 
  select(OWNERNAME, PROPERTYNAME, TOTGHGEMISSIONS_METRICTONSCO2E, TOTGHGEMISSINTENSITY_KGCO2EFT) %>%
  rename(Property_Name = PROPERTYNAME,
         Metric_Tons_CO2 = TOTGHGEMISSIONS_METRICTONSCO2E,
         KGSQFT_CO2 = TOTGHGEMISSINTENSITY_KGCO2EFT)

# Aggregating total sum for GWU and Galludet properties (Consistent with other Universities)
gwu <- emissions %>% 
  filter(OWNERNAME == "GEORGE WASHINGTON UNIVERSITY") %>% 
  group_by(OWNERNAME) %>% 
  summarise(Metric_Tons_CO2 = sum(TOTGHGEMISSIONS_METRICTONSCO2E), 
            KGSQFT_CO2 = sum(TOTGHGEMISSINTENSITY_KGCO2EFT)) %>% 
  mutate(PROPERTYNAME = "GEORGE WASHINGTON UNIVERSITY",
         Property_Name = PROPERTYNAME) %>% 
  select(OWNERNAME, Property_Name, Metric_Tons_CO2, KGSQFT_CO2)

gall <- emissions %>% 
  filter(OWNERNAME == "GALLAUDET UNIVERSITY") %>% 
  group_by(OWNERNAME) %>% 
  summarise(Metric_Tons_CO2 = sum(TOTGHGEMISSIONS_METRICTONSCO2E), 
            KGSQFT_CO2 = sum(TOTGHGEMISSINTENSITY_KGCO2EFT)) %>% 
  mutate(PROPERTYNAME = "Gallaudet University",
         Property_Name = PROPERTYNAME) %>% 
  select(OWNERNAME, Property_Name, Metric_Tons_CO2, KGSQFT_CO2)

# Binding GWU/Galludet back with original list
top <- top %>% 
  rbind(gwu, gall) %>% 
  arrange(desc(Metric_Tons_CO2))
top$Property_Name <- gsub("GEORGE WASHINGTON UNIVERSITY", "George Washington University", top$Property_Name)
top$Property_Name <- gsub("HU Sub Station", "Howard University", top$Property_Name)

write.csv(top, "Tab/Tidy/property_summary.csv", row.names = FALSE)


d <-  top %>%
  filter(Metric_Tons_CO2 >= 10000) %>% 
  mutate(Metric_Tons_CO2 = as.integer(Metric_Tons_CO2),
         KGSQFT_CO2 = as.integer(KGSQFT_CO2)) %>% 
  select(Property_Name, Metric_Tons_CO2, KGSQFT_CO2)

colnames(d) <- c("Property",
                 "Metric Tons \nCO2 Emitted", 'KG/SQFT \nCO2 Emitted')

tt3 <- ttheme_minimal(
  core=list(bg_params = list(fill = blues9[1:10], col=NA),
            fg_params=list(fontface=3)),
  colhead=list(fg_params=list(col="navyblue", fontface=4L)),
  rowhead=list(fg_params=list(col="orange", fontface=3L)))



grid.table(d)

