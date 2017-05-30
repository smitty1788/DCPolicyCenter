library(tidyverse)
library(dplyr)
library("xlsx")

setwd("G:/DC Policy Center/Income Growth/Data/Tab/")


# Income by Race---------------------------------------------------------------------------------------------------
# Read in Income data by Race
State_All_09 <- read_csv("State/Median_Household_Income/ACS_09_5YR_B19013_with_ann.csv")
State_All_10 <- read_csv("State/Median_Household_Income/ACS_10_5YR_B19013_with_ann.csv")
State_All_11 <- read_csv("State/Median_Household_Income/ACS_11_5YR_B19013_with_ann.csv")
State_All_12 <- read_csv("State/Median_Household_Income/ACS_12_5YR_B19013_with_ann.csv")
State_All_13 <- read_csv("State/Median_Household_Income/ACS_13_5YR_B19013_with_ann.csv")
State_All_14 <- read_csv("State/Median_Household_Income/ACS_14_5YR_B19013_with_ann.csv")
State_All_15 <- read_csv("State/Median_Household_Income/ACS_15_5YR_B19013_with_ann.csv")

State_Asian_09 <- read_csv("State/Median_Household_Income_Asian/ACS_09_5YR_B19013D_with_ann.csv")
State_Asian_10 <- read_csv("State/Median_Household_Income_Asian/ACS_10_5YR_B19013D_with_ann.csv")
State_Asian_11 <- read_csv("State/Median_Household_Income_Asian/ACS_11_5YR_B19013D_with_ann.csv")
State_Asian_12 <- read_csv("State/Median_Household_Income_Asian/ACS_12_5YR_B19013D_with_ann.csv")
State_Asian_13 <- read_csv("State/Median_Household_Income_Asian/ACS_13_5YR_B19013D_with_ann.csv")
State_Asian_14 <- read_csv("State/Median_Household_Income_Asian/ACS_14_5YR_B19013D_with_ann.csv")
State_Asian_15 <- read_csv("State/Median_Household_Income_Asian/ACS_15_5YR_B19013D_with_ann.csv")

State_Black_09 <- read_csv("State/Median_Household_Income_Black/ACS_09_5YR_B19013B_with_ann.csv")
State_Black_10 <- read_csv("State/Median_Household_Income_Black/ACS_10_5YR_B19013B_with_ann.csv")
State_Black_11 <- read_csv("State/Median_Household_Income_Black/ACS_11_5YR_B19013B_with_ann.csv")
State_Black_12 <- read_csv("State/Median_Household_Income_Black/ACS_12_5YR_B19013B_with_ann.csv")
State_Black_13 <- read_csv("State/Median_Household_Income_Black/ACS_13_5YR_B19013B_with_ann.csv")
State_Black_14 <- read_csv("State/Median_Household_Income_Black/ACS_14_5YR_B19013B_with_ann.csv")
State_Black_15 <- read_csv("State/Median_Household_Income_Black/ACS_15_5YR_B19013B_with_ann.csv")

State_Hispanic_09 <- read_csv("State/Median_Household_Income_Hispanic/ACS_09_5YR_B19013I_with_ann.csv")
State_Hispanic_10 <- read_csv("State/Median_Household_Income_Hispanic/ACS_10_5YR_B19013I_with_ann.csv")
State_Hispanic_11 <- read_csv("State/Median_Household_Income_Hispanic/ACS_11_5YR_B19013I_with_ann.csv")
State_Hispanic_12 <- read_csv("State/Median_Household_Income_Hispanic/ACS_12_5YR_B19013I_with_ann.csv")
State_Hispanic_13 <- read_csv("State/Median_Household_Income_Hispanic/ACS_13_5YR_B19013I_with_ann.csv")
State_Hispanic_14 <- read_csv("State/Median_Household_Income_Hispanic/ACS_14_5YR_B19013I_with_ann.csv")
State_Hispanic_15 <- read_csv("State/Median_Household_Income_Hispanic/ACS_15_5YR_B19013I_with_ann.csv")

State_White_09 <- read_csv("State/Median_Household_Income_White/ACS_09_5YR_B19013A_with_ann.csv")
State_White_10 <- read_csv("State/Median_Household_Income_White/ACS_10_5YR_B19013A_with_ann.csv")
State_White_11 <- read_csv("State/Median_Household_Income_White/ACS_11_5YR_B19013A_with_ann.csv")
State_White_12 <- read_csv("State/Median_Household_Income_White/ACS_12_5YR_B19013A_with_ann.csv")
State_White_13 <- read_csv("State/Median_Household_Income_White/ACS_13_5YR_B19013A_with_ann.csv")
State_White_14 <- read_csv("State/Median_Household_Income_White/ACS_14_5YR_B19013A_with_ann.csv")
State_White_15 <- read_csv("State/Median_Household_Income_White/ACS_15_5YR_B19013A_with_ann.csv")

# Years that the data covers
years <- c(2009:2015)


# State All------------------------------------------------------------------------------------------------
# List all dataframes
State_All_list <- list(State_All_09, State_All_10, State_All_11, 
                       State_All_12, State_All_13, State_All_14, 
                       State_All_15)
# Remove annotations, rename, select needed columns
State_All_list <- State_All_list %>% 
  lapply(function(x) {
    x[-1,]}) %>%
  lapply(function(x) {
    x %>% 
      rename(MHI_ALL = HD01_VD01) %>% 
      select(MHI_ALL)})

# Bind all dataframes in list and add relevant years
State_All <- do.call("rbind", State_All_list) %>% 
  mutate(Year = years)

# State Asian------------------------------------------------------------------------------------------------
State_Asian_list <- list(State_Asian_09, State_Asian_10, State_Asian_11, 
                         State_Asian_12, State_Asian_13, State_Asian_14, 
                         State_Asian_15)

State_Asian_list <- State_Asian_list %>% 
  lapply(function(x) {
    x[-1,]}) %>%
  lapply(function(x) {
    x %>% 
      rename(MHI_Asian = HD01_VD01) %>% 
      select(MHI_Asian)})

State_Asian <- do.call("rbind", State_Asian_list) %>% 
  mutate(Year = years)


# State Black------------------------------------------------------------------------------------------------
State_Black_list <- list(State_Black_09, State_Black_10, State_Black_11, 
                         State_Black_12, State_Black_13, State_Black_14, 
                         State_Black_15)

State_Black_list <- State_Black_list %>% 
  lapply(function(x) {
    x[-1,]}) %>%
  lapply(function(x) {
    x %>% 
      rename(MHI_Black = HD01_VD01) %>% 
      select(MHI_Black)})

State_Black <- do.call("rbind", State_Black_list) %>% 
  mutate(Year = years)

# State Hispanic------------------------------------------------------------------------------------------------
State_Hispanic_list <- list(State_Hispanic_09, State_Hispanic_10, State_Hispanic_11, 
                            State_Hispanic_12, State_Hispanic_13, State_Hispanic_14, 
                            State_Hispanic_15)

State_Hispanic_list <- State_Hispanic_list %>% 
  lapply(function(x) {
    x[-1,]}) %>%
  lapply(function(x) {
    x %>% 
      rename(MHI_Hispanic = HD01_VD01) %>% 
      select(MHI_Hispanic)})

State_Hispanic <- do.call("rbind", State_Hispanic_list) %>% 
  mutate(Year = years)

# State White------------------------------------------------------------------------------------------------
State_White_list <- list(State_White_09, State_White_10, State_White_11, 
                         State_White_12, State_White_13, State_White_14, 
                         State_White_15)

State_White_list <- State_White_list %>% 
  lapply(function(x) {
    x[-1,]}) %>%
  lapply(function(x) {
    x %>% 
      rename(MHI_White = HD01_VD01) %>% 
      select(MHI_White)})

State_White <- do.call("rbind", State_White_list) %>% 
  mutate(Year = years)


#------------------------------------------------------------------------------------------------------
#Table Joins
State_MHI_Race <- State_All %>% 
  merge(y = State_Asian, by = "Year", all.x = TRUE) %>% 
  merge(y = State_Black, by = "Year", all.x = TRUE) %>%
  merge(y = State_Hispanic, by = "Year", all.x = TRUE) %>% 
  merge(y = State_White, by = "Year", all.x = TRUE) %>% 
  transform(MHI_ALL = as.numeric(MHI_ALL),
            MHI_Asian = as.numeric(MHI_Asian),
            MHI_Black = as.numeric(MHI_Black),
            MHI_Hispanic = as.numeric(MHI_Hispanic),
            MHI_White = as.numeric(MHI_White))
              
#Write to CSV
write.csv(State_MHI_Race, file = "State/State_MHI_Race.csv", row.names = FALSE)


# Income by Age ----------------------------------------------------------------------------------------------------------------------------------
# Import Income data for age
State_Age_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_09_5YR_B19049_with_ann.csv")
State_Age_10 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_10_5YR_B19049_with_ann.csv")
State_Age_11 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_11_5YR_B19049_with_ann.csv")
State_Age_12 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_12_5YR_B19049_with_ann.csv")
State_Age_13 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_13_5YR_B19049_with_ann.csv")
State_Age_14 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_14_5YR_B19049_with_ann.csv")
State_Age_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_15_5YR_B19049_with_ann.csv")


State_Age_list <- list(State_Age_09, State_Age_10, State_Age_11, 
                       State_Age_12, State_Age_13, State_Age_14, 
                       State_Age_15)

State_Age_list <- State_Age_list %>% 
  lapply(function(x) {
    x[-1,]}) %>%
  lapply(function(x) {
    x %>% 
      rename(MHI_ALL = HD01_VD02, 
             MHI_U25 = HD01_VD03, 
             MHI_25_44 = HD01_VD04, 
             MHI_45_64 = HD01_VD05, 
             MHI_65P = HD01_VD06) %>% 
      select(MHI_ALL, MHI_U25, MHI_25_44, MHI_45_64, MHI_65P)})

State_Age <- do.call("rbind", State_Age_list) %>% 
  mutate(Year = years) %>% 
  transform(MHI_ALL = as.numeric(MHI_ALL),
            MHI_U25 = as.numeric(MHI_U25),
            MHI_25_44 = as.numeric(MHI_25_44),
            MHI_45_64 = as.numeric(MHI_45_64),
            MHI_65P = as.numeric(MHI_65P))

#Write to CSV
write.csv(State_Age, file = "State/State_MHI_Age.csv", row.names = FALSE)



# Income by Sex, Non Family Households-----------------------------------------------------------------------------------------------------------------------------------------------
# Import Income data for Race
State_Sex_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_09_5YR_B19215_with_ann.csv")
State_Sex_10 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_10_5YR_B19215_with_ann.csv")
State_Sex_11 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_11_5YR_B19215_with_ann.csv")
State_Sex_12 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_12_5YR_B19215_with_ann.csv")
State_Sex_13 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_13_5YR_B19215_with_ann.csv")
State_Sex_14 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_14_5YR_B19215_with_ann.csv")
State_Sex_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_15_5YR_B19215_with_ann.csv")

State_Sex_list <- list(State_Sex_09, State_Sex_10, State_Sex_11, 
                       State_Sex_12, State_Sex_13, State_Sex_14, 
                       State_Sex_15)

State_Sex_list <- State_Sex_list %>% 
  lapply(function(x) {
    x[-1,]}) %>%
  lapply(function(x) {
    x %>% 
      rename(MHI_ALL = HD01_VD02,
             MHI_Male = HD01_VD04,
             MHI_Female = HD01_VD14) %>% 
      select(MHI_ALL,
             MHI_Male,
             MHI_Female)})

State_Sex <- do.call("rbind", State_Sex_list) %>% 
  mutate(Year = years) %>% 
  transform(MHI_ALL = as.numeric(MHI_ALL),
            MHI_Male = as.numeric(MHI_Male),
            MHI_Female = as.numeric(MHI_Female))

#Write to CSV
write.csv(State_Sex, file = "State/State_MHI_Sex.csv", row.names = FALSE)


# Census Tract Income by Race----------------------------------------------------------------------------------------------------------------------------------------------
# Read in Data
CT_All_09 <- read_csv("Census_Tract/Median_Household_Income/ACS_09_5YR_B19013_with_ann.csv", col_types = cols(GEO.id2 = col_character(), HD01_VD01 = col_double()))
CT_All_15 <- read_csv("Census_Tract/Median_Household_Income/ACS_15_5YR_B19013_with_ann.csv", col_types = cols(GEO.id2 = col_character(), HD01_VD01 = col_double()))

CT_Asian_09 <- read_csv("Census_Tract/Median_Household_Income_Asian/ACS_09_5YR_B19013D_with_ann.csv", col_types = cols(GEO.id2 = col_character(), HD01_VD01 = col_double()))
CT_Asian_15 <- read_csv("Census_Tract/Median_Household_Income_Asian/ACS_15_5YR_B19013D_with_ann.csv", col_types = cols(GEO.id2 = col_character(), HD01_VD01 = col_double()))

CT_Black_09 <- read_csv("Census_Tract/Median_Household_Income_Black/ACS_09_5YR_B19013B_with_ann.csv", col_types = cols(GEO.id2 = col_character(), HD01_VD01 = col_double()))
CT_Black_15 <- read_csv("Census_Tract/Median_Household_Income_Black/ACS_15_5YR_B19013B_with_ann.csv", col_types = cols(GEO.id2 = col_character(), HD01_VD01 = col_double()))

CT_Hispanic_09 <- read_csv("Census_Tract/Median_Household_Income_Hispanic/ACS_09_5YR_B19013I_with_ann.csv", col_types = cols(GEO.id2 = col_character(), HD01_VD01 = col_double()))
CT_Hispanic_15 <- read_csv("Census_Tract/Median_Household_Income_Hispanic/ACS_15_5YR_B19013I_with_ann.csv", col_types = cols(GEO.id2 = col_character(), HD01_VD01 = col_double()))

CT_White_09 <- read_csv("Census_Tract/Median_Household_Income_White/ACS_09_5YR_B19013A_with_ann.csv", col_types = cols(GEO.id2 = col_character(), HD01_VD01 = col_double()))
CT_White_15 <- read_csv("Census_Tract/Median_Household_Income_White/ACS_15_5YR_B19013A_with_ann.csv", col_types = cols(GEO.id2 = col_character(), HD01_VD01 = col_double()))

# Create list to remove annotations row
CT_list <- list(CT_All_09, CT_All_15, CT_Asian_09, CT_Asian_15, CT_Black_09,CT_Black_15, CT_Hispanic_09, CT_Hispanic_15, CT_White_09, CT_White_15)

# remove annotation row
CT_list <- CT_list %>% 
  lapply(function(x) {
    x[-1,]})

# Unlist
for (i in seq(CT_list))
  assign(paste("df" ,i, sep = ""), CT_list[[i]])

# Rename and select relavent columns
CT_All_09 <- df1 %>% 
  rename(GEOID = GEO.id2, MHI_ALL_09 = HD01_VD01) %>% 
  select(GEOID, MHI_ALL_09)

CT_All_15 <- df2  %>% 
  rename(GEOID = GEO.id2, MHI_ALL_15 = HD01_VD01) %>% 
  select(GEOID, MHI_ALL_15)

CT_Asian_09 <- df3 %>% 
  rename(GEOID = GEO.id2, MHI_Asian_09 = HD01_VD01) %>% 
  select(GEOID, MHI_Asian_09)

CT_Asian_15 <- df4 %>% 
  rename(GEOID = GEO.id2, MHI_Asian_15 = HD01_VD01) %>% 
  select(GEOID, MHI_Asian_15)

CT_Black_09 <- df5 %>% 
  rename(GEOID = GEO.id2, MHI_Black_09 = HD01_VD01) %>% 
  select(GEOID, MHI_Black_09)

CT_Black_15 <- df6 %>% 
  rename(GEOID = GEO.id2, MHI_Black_15 = HD01_VD01) %>% 
  select(GEOID, MHI_Black_15)

CT_Hispanic_09 <- df5 %>% 
  rename(GEOID = GEO.id2, MHI_Hispanic_09 = HD01_VD01) %>% 
  select(GEOID, MHI_Hispanic_09)

CT_Hispanic_15 <- df6 %>%  
  rename(GEOID = GEO.id2, MHI_Hispanic_15 = HD01_VD01) %>% 
  select(GEOID, MHI_Hispanic_15)

CT_White_09 <- df5 %>% 
  rename(GEOID = GEO.id2, MHI_White_09 = HD01_VD01) %>% 
  select(GEOID, MHI_White_09)

CT_White_15 <- df6 %>%  
  rename(GEOID = GEO.id2, MHI_White_15 = HD01_VD01) %>% 
  select(GEOID, MHI_White_15)

#Table Joins
CT_MHI_Race <- CT_All_09 %>% 
  merge(y = CT_All_15, by = "GEOID", all.x = TRUE) %>% 
  merge(y = CT_Asian_09, by = "GEOID", all.x = TRUE) %>% 
  merge(y = CT_Asian_15, by = "GEOID", all.x = TRUE) %>% 
  merge(y = CT_Black_09, by = "GEOID", all.x = TRUE) %>% 
  merge(y = CT_Black_15, by = "GEOID", all.x = TRUE) %>% 
  merge(y = CT_Hispanic_09, by = "GEOID", all.x = TRUE) %>% 
  merge(y = CT_Hispanic_15, by = "GEOID", all.x = TRUE) %>% 
  merge(y = CT_White_09, by = "GEOID", all.x = TRUE) %>% 
  merge(y = CT_White_15, by = "GEOID", all.x = TRUE) %>%
  
  mutate(MHI_ALL_Change = (MHI_ALL_15 - MHI_ALL_09) / MHI_ALL_09 * 100,
         MHI_Asian_Change = (MHI_Asian_15 - MHI_Asian_09) / MHI_Asian_09 * 100,
         MHI_Black_Change = (MHI_Black_15 - MHI_Black_09) / MHI_Black_09 * 100,
         MHI_Hispanic_Change = (MHI_Hispanic_15 - MHI_Hispanic_09) / MHI_Hispanic_09 * 100,
         MHI_White_Change = (MHI_White_15 - MHI_White_09) / MHI_White_09 * 100)

write.xlsx(CT_MHI_Race, file = "Census_Tract/CT_MHI_Race.xlsx",
           sheetName = "CT_MHI_Race",
           row.names = FALSE)




# Census Tracts Income by Age-------------------------------------------------------------------------------------------------------------------------------------------
# Import Income data for age
CT_Age_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income_Age/ACS_09_5YR_B19049_with_ann.csv")
CT_Age_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income_Age/ACS_15_5YR_B19049_with_ann.csv")


# Remove annotation
CT_Age_09 <- CT_Age_09[-1,]
CT_Age_15 <- CT_Age_15[-1,]

# Rename and select relavent columns
CT_Age_09 <- CT_Age_09 %>% 
  as.data.frame(sapply(sub, pattern = '-', replacement = NA)) %>%
  rename(GEOID = GEO.id2, MHI_ALL_09 = HD01_VD02, MHI_U25_09 = HD01_VD03, MHI_25_44_09 = HD01_VD04, MHI_45_64_09 = HD01_VD05, MHI_65P_09 = HD01_VD06) %>%
  select(GEOID, MHI_ALL_09, MHI_U25_09, MHI_25_44_09, MHI_45_64_09, MHI_65P_09)
  
CT_Age_15 <- CT_Age_15 %>% 
  as.data.frame(sapply(sub, pattern = '-', replacement = NA)) %>% 
  rename(GEOID = GEO.id2, MHI_ALL_15 = HD01_VD02, MHI_U25_15 = HD01_VD03, MHI_25_44_15 = HD01_VD04, MHI_45_64_15 = HD01_VD05, MHI_65P_15 = HD01_VD06) %>% 
  select(GEOID, MHI_ALL_15, MHI_U25_15, MHI_25_44_15, MHI_45_64_15, MHI_65P_15)
  
#Table Joins
CT_MHI_Age <- merge(x = CT_Age_09, y = CT_Age_15, by = "GEOID", all.x = TRUE)


# Convert MHI to numberic and GEOID to string, find % increase from 2009 to 2015
CT_MHI_Age <- CT_MHI_Age %>% 
  transform(GEOID = as.character(GEOID),
            MHI_ALL_09 = as.numeric(MHI_ALL_09),
            MHI_ALL_15 = as.numeric(MHI_ALL_15),
            MHI_U25_09 = as.numeric(MHI_U25_09),
            MHI_U25_15 = as.numeric(MHI_U25_15),
            MHI_25_44_09 = as.numeric(MHI_25_44_09),
            MHI_25_44_15 = as.numeric(MHI_25_44_15),
            MHI_45_64_09 = as.numeric(MHI_45_64_09),
            MHI_45_64_15 = as.numeric(MHI_45_64_15),
            MHI_65P_09 = as.numeric(MHI_65P_09),
            MHI_65P_15 = as.numeric(MHI_65P_15)) %>% 
  mutate(MHI_ALL_Change = (MHI_ALL_15 - MHI_ALL_09) / MHI_ALL_09 * 100,
         MHI_U25_Change = (MHI_U25_15 - MHI_U25_09) / MHI_U25_09 * 100,
         MHI_25_44_Change = (MHI_25_44_15 - MHI_25_44_09) / MHI_25_44_09 * 100,
         MHI_45_64_Change = (MHI_45_64_15 - MHI_45_64_09) / MHI_45_64_09 * 100,
         MHI_65P_Change = ( MHI_65P_15 -  MHI_65P_09) /  MHI_65P_09 * 100)


write.xlsx(CT_MHI_Age, file = "Census_Tract/CT_MHI_Age.xlsx",
           sheetName = "CT_MHI_Age",
           row.names = FALSE)
                   
