library(hrbrthemes)
library(gcookbook)
library("xlsx")
library(tidyr)
library(sqldf)
library(tidyverse)


#Import Raw Data
Cities_Health <- read_csv("G:/DC Policy Center/Urban Heat Island/Data/Tab/500_Cities__Local_Data_for_Better_Health.csv")


# Filter only DC Census Tracts
DC <- sqldf("select * from Cities_Health where StateAbbr is 'DC' AND GeographicLevel is 'Census Tract'") %>%
  
  # Select relevant columns 
  select(TractFIPS,
         PopulationCount,
         Short_Question_Text,
         Data_Value) %>%
  
  #transpose data to wide format
  spread(key = Short_Question_Text, value = Data_Value) %>%
  
  #convert from unknown to numeric
  apply(2,as.numeric) %>%
  
  # convert GEOID to string
  transform(GEOID = as.character(TractFIPS)) 

# Remove all "." from column names
names(DC) <- gsub("\\.", "", names(DC))


# Write to xlsx to join in ArcMap
write.xlsx(DC, file = "G:/DC Policy Center/Urban Heat Island/Data/Tab/Tidy/DC_Health.xlsx", sheetName = "Health", row.names = FALSE)






#-------------------------------------------------------------------------------------------------------------------------
# Import data on living alone
DC_Alone <- read_csv("G:/DC Policy Center/Urban Heat Island/Data/Tab/Household_Living_Alone/ACS_15_5YR_S2501_with_ann.csv")
  
# Remove Annotations  
DC_Alone = DC_Alone[-1,]

DC_Alone <- DC_Alone %>% 
  
  # Transform to numeric and characters
  transform(GEOID = as.character(GEO.id2),
            Households = as.numeric(HC01_EST_VC01),
            Own_Alone = as.numeric(HC02_EST_VC29),
            Rent_Alone = as.numeric(HC03_EST_VC29),
            Own_Alone_65 = as.numeric(HC01_EST_VC32),
            Rent_Alone_65 = as.numeric(HC01_EST_VC32)) %>%
  
  # Remove NA rows
  na.omit() %>%
  
  #calculate percentage living along
  mutate(Live_Alone = (Own_Alone + Rent_Alone) / Households * 100,
         Live_Alone_65 = (Own_Alone_65 + Rent_Alone_65) / Households * 100) %>%
  
  #select relevant columns
  select(GEOID,
         Live_Alone,
         Live_Alone_65)
  


#----------------------------------------------------------------------------------------------------------------------------------
# Import Temp and health data from ArcMap
DC_Temp <- read_csv("G:/DC Policy Center/Urban Heat Island/Data/Tab/Combined_Temp_Demo.csv") %>%
  
  # Select relevant columns
  select(GEOID,
         Temp,
         NDVI,
         PopulationCount,
         PhysicalHealth,
         Total,
         White,
         NoDiploma,
         A65_69,
         A70_74,
         A75_79,
         A80_84,
         A85P,
         MedianHouseholdIncome,
         P_Uninsured,
         P_BelowPovertyLevel) %>%
  
  transform(GEOID = as.character(GEOID)) %>%
  
  # Calculate Population in each tract in Poor Health
  mutate(Poor_Health = PopulationCount * (PhysicalHealth / 100),
         Temp_STD = (Temp - mean(Temp)) / sd(Temp),
         NDVI_STD = (NDVI - mean(NDVI)) / sd(NDVI))


  
#-----------------------------------------------------------------------------------------------------------------------------------
# Merge Temp/Demo data with Living alone data
DC_HVI <- merge(x = DC_Temp, y = DC_Alone, by = "GEOID", all.x = TRUE)



#----------------------------------------------------------------------------------------------------------------------------
#Calculate Heat Vulnerbility Index per census tract  
DC_HVI <- DC_HVI %>%
  
  #Calculate percentage fields we dont have 
  mutate(P_Not_White = (Total - White) / Total * 100,
         P_No_HS = NoDiploma / Total * 100,
         P_Over_65 = A65_69 + A70_74 + A75_79 + A80_84 + A85P,
         NDVI_Reverse = NDVI * -1) %>%
  
  # Select only vulnerbility factors
  select(GEOID,
         Temp,
         Temp_STD,
         NDVI,
         NDVI_Reverse,
         NDVI_STD,
         Total,
         P_BelowPovertyLevel,
         P_Uninsured,
         PhysicalHealth,
         P_Not_White,
         P_No_HS,
         P_Over_65,
         Live_Alone,
         Live_Alone_65
         )
  
  
# Calculate HVI Score  
HVI_Ranking <-  DC_HVI %>%
  
  # Convert percentages to 1(Least) through 10(Worst) ranks, 
  within(R_Temp_STD <- as.integer(cut(Temp_STD, quantile(Temp_STD, probs=0:10/10), include.lowest=TRUE))) %>%
  within(R_NDVI <- as.integer(cut(NDVI_Reverse, quantile(NDVI_Reverse, probs=0:10/10), include.lowest=TRUE))) %>%
  within(R_Poverty <- as.integer(cut(P_BelowPovertyLevel, quantile(P_BelowPovertyLevel, probs=0:10/10), include.lowest=TRUE))) %>%
  within(R_Uninsured <- as.integer(cut(P_Uninsured, quantile(P_Uninsured, probs=0:10/10), include.lowest=TRUE))) %>%
  within(R_Health <- as.integer(cut(PhysicalHealth, quantile(PhysicalHealth, probs=0:10/10), include.lowest=TRUE))) %>%
  within(R_Not_White <- as.integer(cut(P_Not_White, quantile(P_Not_White, probs=0:10/10), include.lowest=TRUE))) %>%
  within(R_No_HS <- as.integer(cut(P_No_HS, quantile(P_No_HS, probs=0:10/10), include.lowest=TRUE))) %>%
  within(R_O65 <- as.integer(cut(P_Over_65, quantile(P_Over_65, probs=0:10/10), include.lowest=TRUE))) %>%
  within(R_LA <- as.integer(cut(Live_Alone, quantile(Live_Alone, probs=0:10/10, na.rm = TRUE), include.lowest=TRUE))) %>%
  within(R_LA65 <- as.integer(cut(Live_Alone_65, quantile(Live_Alone_65, probs=0:10/10, na.rm = TRUE), include.lowest=TRUE))) %>%
  
  # Calculate Score. Weights are subjective and likely to change
  mutate(HVI = (( 0.15 * R_Temp_STD) + ( 0.1 * R_NDVI) + ( 0.15 * R_Poverty) + ( 0.05 * R_Uninsured) + ( 0.15 * R_Health) + ( 0.03 * R_Not_White) + ( 0.02 * R_No_HS) + ( 0.1 * R_O65) + ( 0.05 * R_LA) + ( 0.15 * R_LA65)) / 10,
         Heat_Capacity = ( 0.5 * Temp_STD) + ( 0.5 * NDVI_STD))

HVI_Ranking <- na.omit(HVI_Ranking)

# Write to xlsx to join in ArcMap
write.xlsx(HVI_Ranking, file = "G:/DC Policy Center/Urban Heat Island/Data/Tab/Tidy/HVI_Ranking.xlsx", sheetName = "HVI", row.names = FALSE)



#--------------------------------------------------------------------------------------------------------------------------------
# Identify Heat Islands and some key stats
# Filter only tracts that are >= 1SD of average temparture
DC_Heat_Islands <- DC_Temp %>%
  filter( Temp >= mean(Temp) + sd(Temp))


# Total Population in Poor Health
sum(DC_Heat_Islands$Poor_Health)
# 7201
sd(DC_Heat_Islands$Poor_Health)
# 143


# Median Houshold Income of those tracts
mean(DC_Heat_Islands$MedianHouseholdIncome)
# $62332.18
sd(DC_Heat_Islands$MedianHouseholdIncome)
# $34184.95


# Avg percent uninsured in those tracts
mean(DC_Heat_Islands$P_Uninsured)
# 8.031818%
sd(DC_Heat_Islands$P_Uninsured)
# 3.811934


# Avg percent below poverty level in those tracts
mean(DC_Heat_Islands$P_BelowPovertyLevel)
# 22.55909%
sd(DC_Heat_Islands$P_BelowPovertyLevel)
# 11.70652%



#------------------------------------------------------------------------------------------------
# NDVI and Temperature relationship graph
#Import Data
Temp_NDVI_Points <- read_csv("G:/DC Policy Center/Urban Heat Island/Data/Tab/Temp_NDVI_Points.csv")


#Calculate STD of Temp
rsq <- Temp_NDVI_Points %>%
  mutate(Temp_STD = (Temp - mean(Temp)) / sd(Temp),
         NDVI_STD = (NDVI - mean(NDVI)) / sd(NDVI))  


# Write to csv
write.csv(rsq, "G:/DC Policy Center/Urban Heat Island/Data/Tab/Tidy/Temp_NDVI.csv", row.names = FALSE)


# Create Graph
rsq %>%
  filter(NDVI >= 0 & Temp_STD >= -2) %>%
ggplot(mapping = aes(x = NDVI, y = Temp_STD)) +
         geom_smooth(size = 2, colour = "#527394") +
  labs(x ="Normalized Difference Vegetation Index", y ="Temperature, Std. Dev from Mean",
       title = "Influence of NDVI on Temperature",
       subtitle = "Washington, D.C., August 2015",
       caption = "Source: NASA Landsat8, August 2015") + 
  theme_ipsum_rc()
       

