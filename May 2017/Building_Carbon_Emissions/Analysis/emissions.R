# Analysis of Building CO2 Emissions in Washington D.C.
# For: D.C. Policy Center
# Author: Randy Smith

library(tidyverse)
library(lubridate)

# Set working Directory
setwd("G:/DC Policy Center/Carbon Emmisions/Data")

# Read in Data
# Original Dataset from 
# http://opendata.dc.gov/datasets/2014-building-energy-and-water-performance-benchmarking
# Due to inconsistent formating, much of the data cleanup
# had to be done by hand 
emissions <- read.csv('Tab/building_emissions.csv', stringsAsFactors = FALSE)

# Addressing inconsistant naming schemes
emissions$OWNEROFRECORD <- gsub("GEORGE WASHINGTON UNIVERSITY", "George Washington University", emissions$OWNEROFRECORD)
emissions$OWNEROFRECORD <- gsub("GEORGE WASHINGTON", "George Washington University", emissions$OWNEROFRECORD)
emissions$OWNEROFRECORD <- gsub("THE GEORGE WASHINGTON UNIVERSITY", "George Washington University", emissions$OWNEROFRECORD)
emissions$OWNEROFRECORD <- gsub("THE George Washington University", "George Washington University", emissions$OWNEROFRECORD)
emissions$OWNEROFRECORD <- gsub("GEORGETOWN COLLEGE LAW CENTER", "GEORGETOWN UNIVERSITY", emissions$OWNEROFRECORD)
emissions$OWNEROFRECORD <- gsub("JESUIT COMMUNITY AT GEORGETOWN UNIV INC", "GEORGETOWN UNIVERSITY", emissions$OWNEROFRECORD)


# Top emitting properties
top_prop <- emissions %>%
  rename(Owner = OWNEROFRECORD,
         Type = PRIMARYPROPERTYTYPE_SELFSELECT) %>%
  mutate(Type = if_else(Owner %in% c('George Washington University', 'GEORGETOWN UNIVERSITY'), 'College/University', Type),
         Owner = if_else(PROPERTYNAME == "Children's National Medical Center", "Children's National Medical Center", Owner)) %>% 
  group_by(Owner, Type) %>% 
  summarise(Metric_Tons_CO2 = sum(TOTGHGEMISSIONS_METRICTONSCO2E, na.rm = TRUE),
            KGSQFT_CO2 = sum(TOTGHGEMISSINTENSITY_KGCO2EFT, na.rm = TRUE)) %>% 
  arrange(desc(Metric_Tons_CO2))


# Top emmissions by College/University
colleges <- top_prop %>% 
  filter(Type == 'College/University') %>% 
  arrange(desc(KGSQFT_CO2))

# Enrollment Data
# Data gathered from each universities respective wikipedia page
uni_names <- sort(unique(colleges$Owner))

uni_enrollment <- tibble(
  Owner = uni_names,
  enrollment = c(13200, 2340, 27159, 17849, 10300, NA, NA, 6521, NA, NA, 2100)
)

# College emissions by enrollment
college_emissions <- colleges %>% 
  merge(uni_enrollment, by = 'Owner') %>% 
  mutate(CO2_Enrollment = round(Metric_Tons_CO2 / enrollment, 1)) %>% 
  arrange(desc(CO2_Enrollment)) %>% 
  filter(!is.na(CO2_Enrollment))

# write data to csv
write.csv(top_prop, 'Tab/Tidy/top_emissions.csv', row.names = FALSE)
write.csv(college_emissions, 'Tab/Tidy/college_emissions.csv', row.names = FALSE)

