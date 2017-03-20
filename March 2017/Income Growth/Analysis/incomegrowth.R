library(tidyverse)
library(dplyr)
library("xlsx")


# Income by Race
# Import Income data for Race
State_All_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income/ACS_09_5YR_B19013_with_ann.csv")
State_All_10 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income/ACS_10_5YR_B19013_with_ann.csv")
State_All_11 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income/ACS_11_5YR_B19013_with_ann.csv")
State_All_12 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income/ACS_12_5YR_B19013_with_ann.csv")
State_All_13 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income/ACS_13_5YR_B19013_with_ann.csv")
State_All_14 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income/ACS_14_5YR_B19013_with_ann.csv")
State_All_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income/ACS_15_5YR_B19013_with_ann.csv")

State_Asian_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Asian/ACS_09_5YR_B19013D_with_ann.csv")
State_Asian_10 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Asian/ACS_10_5YR_B19013D_with_ann.csv")
State_Asian_11 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Asian/ACS_11_5YR_B19013D_with_ann.csv")
State_Asian_12 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Asian/ACS_12_5YR_B19013D_with_ann.csv")
State_Asian_13 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Asian/ACS_13_5YR_B19013D_with_ann.csv")
State_Asian_14 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Asian/ACS_14_5YR_B19013D_with_ann.csv")
State_Asian_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Asian/ACS_15_5YR_B19013D_with_ann.csv")

State_Black_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Black/ACS_09_5YR_B19013B_with_ann.csv")
State_Black_10 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Black/ACS_10_5YR_B19013B_with_ann.csv")
State_Black_11 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Black/ACS_11_5YR_B19013B_with_ann.csv")
State_Black_12 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Black/ACS_12_5YR_B19013B_with_ann.csv")
State_Black_13 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Black/ACS_13_5YR_B19013B_with_ann.csv")
State_Black_14 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Black/ACS_14_5YR_B19013B_with_ann.csv")
State_Black_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Black/ACS_15_5YR_B19013B_with_ann.csv")

State_Hispanic_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Hispanic/ACS_09_5YR_B19013I_with_ann.csv")
State_Hispanic_10 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Hispanic/ACS_10_5YR_B19013I_with_ann.csv")
State_Hispanic_11 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Hispanic/ACS_11_5YR_B19013I_with_ann.csv")
State_Hispanic_12 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Hispanic/ACS_12_5YR_B19013I_with_ann.csv")
State_Hispanic_13 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Hispanic/ACS_13_5YR_B19013I_with_ann.csv")
State_Hispanic_14 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Hispanic/ACS_14_5YR_B19013I_with_ann.csv")
State_Hispanic_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Hispanic/ACS_15_5YR_B19013I_with_ann.csv")

State_White_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_White/ACS_09_5YR_B19013A_with_ann.csv")
State_White_10 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_White/ACS_10_5YR_B19013A_with_ann.csv")
State_White_11 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_White/ACS_11_5YR_B19013A_with_ann.csv")
State_White_12 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_White/ACS_12_5YR_B19013A_with_ann.csv")
State_White_13 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_White/ACS_13_5YR_B19013A_with_ann.csv")
State_White_14 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_White/ACS_14_5YR_B19013A_with_ann.csv")
State_White_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_White/ACS_15_5YR_B19013A_with_ann.csv")


# Remove Annotations row
State_All_09 <- State_All_09[-1,]
State_All_10 <- State_All_10[-1,]
State_All_11 <- State_All_11[-1,]
State_All_12 <- State_All_12[-1,]
State_All_13 <- State_All_13[-1,]
State_All_14 <- State_All_14[-1,]
State_All_15 <- State_All_15[-1,]

State_Asian_09 <- State_Asian_09[-1,]
State_Asian_10 <- State_Asian_10[-1,]
State_Asian_11 <- State_Asian_11[-1,]
State_Asian_12 <- State_Asian_12[-1,]
State_Asian_13 <- State_Asian_13[-1,]
State_Asian_14 <- State_Asian_14[-1,]
State_Asian_15 <- State_Asian_15[-1,]

State_Black_09 <- State_Black_09[-1,]
State_Black_10 <- State_Black_10[-1,]
State_Black_11 <- State_Black_11[-1,]
State_Black_12 <- State_Black_12[-1,]
State_Black_13 <- State_Black_13[-1,]
State_Black_14 <- State_Black_14[-1,]
State_Black_15 <- State_Black_15[-1,]

State_Hispanic_09 <- State_Hispanic_09[-1,]
State_Hispanic_10 <- State_Hispanic_10[-1,]
State_Hispanic_11 <- State_Hispanic_11[-1,]
State_Hispanic_12 <- State_Hispanic_12[-1,]
State_Hispanic_13 <- State_Hispanic_13[-1,]
State_Hispanic_14 <- State_Hispanic_14[-1,]
State_Hispanic_15 <- State_Hispanic_15[-1,]

State_White_09 <- State_White_09[-1,]
State_White_10 <- State_White_10[-1,]
State_White_11 <- State_White_11[-1,]
State_White_12 <- State_White_12[-1,]
State_White_13 <- State_White_13[-1,]
State_White_14 <- State_White_14[-1,]
State_White_15 <- State_White_15[-1,]


#Rename attributes
State_All_09 <- rename(State_All_09, MHI_ALL = HD01_VD01)
State_All_10 <- rename(State_All_10, MHI_ALL = HD01_VD01)
State_All_11 <- rename(State_All_11, MHI_ALL = HD01_VD01)
State_All_12 <- rename(State_All_12, MHI_ALL = HD01_VD01)
State_All_13 <- rename(State_All_13, MHI_ALL = HD01_VD01)
State_All_14 <- rename(State_All_14, MHI_ALL = HD01_VD01)
State_All_15 <- rename(State_All_15, MHI_ALL = HD01_VD01)

State_Asian_09 <- rename(State_Asian_09, MHI_Asian = HD01_VD01)
State_Asian_10 <- rename(State_Asian_10, MHI_Asian = HD01_VD01)
State_Asian_11 <- rename(State_Asian_11, MHI_Asian = HD01_VD01)
State_Asian_12 <- rename(State_Asian_12, MHI_Asian = HD01_VD01)
State_Asian_13 <- rename(State_Asian_13, MHI_Asian = HD01_VD01)
State_Asian_14 <- rename(State_Asian_14, MHI_Asian = HD01_VD01)
State_Asian_15 <- rename(State_Asian_15, MHI_Asian = HD01_VD01)

State_Black_09 <- rename(State_Black_09, MHI_Black = HD01_VD01)
State_Black_10 <- rename(State_Black_10, MHI_Black = HD01_VD01)
State_Black_11 <- rename(State_Black_11, MHI_Black = HD01_VD01)
State_Black_12 <- rename(State_Black_12, MHI_Black = HD01_VD01)
State_Black_13 <- rename(State_Black_13, MHI_Black = HD01_VD01)
State_Black_14 <- rename(State_Black_14, MHI_Black = HD01_VD01)
State_Black_15 <- rename(State_Black_15, MHI_Black = HD01_VD01)

State_Hispanic_09 <- rename(State_Hispanic_09, MHI_Hispanic = HD01_VD01)
State_Hispanic_10 <- rename(State_Hispanic_10, MHI_Hispanic = HD01_VD01)
State_Hispanic_11 <- rename(State_Hispanic_11, MHI_Hispanic = HD01_VD01)
State_Hispanic_12 <- rename(State_Hispanic_12, MHI_Hispanic = HD01_VD01)
State_Hispanic_13 <- rename(State_Hispanic_13, MHI_Hispanic = HD01_VD01)
State_Hispanic_14 <- rename(State_Hispanic_14, MHI_Hispanic = HD01_VD01)
State_Hispanic_15 <- rename(State_Hispanic_15, MHI_Hispanic = HD01_VD01)

State_White_09 <- rename(State_White_09, MHI_White = HD01_VD01)
State_White_10 <- rename(State_White_10, MHI_White = HD01_VD01)
State_White_11 <- rename(State_White_11, MHI_White = HD01_VD01)
State_White_12 <- rename(State_White_12, MHI_White = HD01_VD01)
State_White_13 <- rename(State_White_13, MHI_White = HD01_VD01)
State_White_14 <- rename(State_White_14, MHI_White = HD01_VD01)
State_White_15 <- rename(State_White_15, MHI_White = HD01_VD01)


#Add year to each dataset
State_All_09 <- mutate(State_All_09, Year = 2009)
State_All_10 <- mutate(State_All_10, Year = 2010)
State_All_11 <- mutate(State_All_11, Year = 2011)
State_All_12 <- mutate(State_All_12, Year = 2012)
State_All_13 <- mutate(State_All_13, Year = 2013)
State_All_14 <- mutate(State_All_14, Year = 2014)
State_All_15 <- mutate(State_All_15, Year = 2015)

State_Asian_09 <- mutate(State_Asian_09, Year = 2009)
State_Asian_10 <- mutate(State_Asian_10, Year = 2010)
State_Asian_11 <- mutate(State_Asian_11, Year = 2011)
State_Asian_12 <- mutate(State_Asian_12, Year = 2012)
State_Asian_13 <- mutate(State_Asian_13, Year = 2013)
State_Asian_14 <- mutate(State_Asian_14, Year = 2014)
State_Asian_15 <- mutate(State_Asian_15, Year = 2015)

State_Black_09 <- mutate(State_Black_09, Year = 2009)
State_Black_10 <- mutate(State_Black_10, Year = 2010)
State_Black_11 <- mutate(State_Black_11, Year = 2011)
State_Black_12 <- mutate(State_Black_12, Year = 2012)
State_Black_13 <- mutate(State_Black_13, Year = 2013)
State_Black_14 <- mutate(State_Black_14, Year = 2014)
State_Black_15 <- mutate(State_Black_15, Year = 2015)

State_Hispanic_09 <- mutate(State_Hispanic_09, Year = 2009)
State_Hispanic_10 <- mutate(State_Hispanic_10, Year = 2010)
State_Hispanic_11 <- mutate(State_Hispanic_11, Year = 2011)
State_Hispanic_12 <- mutate(State_Hispanic_12, Year = 2012)
State_Hispanic_13 <- mutate(State_Hispanic_13, Year = 2013)
State_Hispanic_14 <- mutate(State_Hispanic_14, Year = 2014)
State_Hispanic_15 <- mutate(State_Hispanic_15, Year = 2015)

State_White_09 <- mutate(State_White_09, Year = 2009)
State_White_10 <- mutate(State_White_10, Year = 2010)
State_White_11 <- mutate(State_White_11, Year = 2011)
State_White_12 <- mutate(State_White_12, Year = 2012)
State_White_13 <- mutate(State_White_13, Year = 2013)
State_White_14 <- mutate(State_White_14, Year = 2014)
State_White_15 <- mutate(State_White_15, Year = 2015)


#Select MHI and Year
State_All_09 <- select(State_All_09, MHI_ALL, Year)
State_All_10 <- select(State_All_10, MHI_ALL, Year)
State_All_11 <- select(State_All_11, MHI_ALL, Year)
State_All_12 <- select(State_All_12, MHI_ALL, Year)
State_All_13 <- select(State_All_13, MHI_ALL, Year)
State_All_14 <- select(State_All_14, MHI_ALL, Year)
State_All_15 <- select(State_All_15, MHI_ALL, Year)

State_Asian_09 <- select(State_Asian_09, MHI_Asian, Year)
State_Asian_10 <- select(State_Asian_10, MHI_Asian, Year)
State_Asian_11 <- select(State_Asian_11, MHI_Asian, Year)
State_Asian_12 <- select(State_Asian_12, MHI_Asian, Year)
State_Asian_13 <- select(State_Asian_13, MHI_Asian, Year)
State_Asian_14 <- select(State_Asian_14, MHI_Asian, Year)
State_Asian_15 <- select(State_Asian_15, MHI_Asian, Year)

State_Black_09 <- select(State_Black_09, MHI_Black, Year)
State_Black_10 <- select(State_Black_10, MHI_Black, Year)
State_Black_11 <- select(State_Black_11, MHI_Black, Year)
State_Black_12 <- select(State_Black_12, MHI_Black, Year)
State_Black_13 <- select(State_Black_13, MHI_Black, Year)
State_Black_14 <- select(State_Black_14, MHI_Black, Year)
State_Black_15 <- select(State_Black_15, MHI_Black, Year)

State_Hispanic_09 <- select(State_Hispanic_09, MHI_Hispanic, Year)
State_Hispanic_10 <- select(State_Hispanic_10, MHI_Hispanic, Year)
State_Hispanic_11 <- select(State_Hispanic_11, MHI_Hispanic, Year)
State_Hispanic_12 <- select(State_Hispanic_12, MHI_Hispanic, Year)
State_Hispanic_13 <- select(State_Hispanic_13, MHI_Hispanic, Year)
State_Hispanic_14 <- select(State_Hispanic_14, MHI_Hispanic, Year)
State_Hispanic_15 <- select(State_Hispanic_15, MHI_Hispanic, Year)

State_White_09 <- select(State_White_09, MHI_White, Year)
State_White_10 <- select(State_White_10, MHI_White, Year)
State_White_11 <- select(State_White_11, MHI_White, Year)
State_White_12 <- select(State_White_12, MHI_White, Year)
State_White_13 <- select(State_White_13, MHI_White, Year)
State_White_14 <- select(State_White_14, MHI_White, Year)
State_White_15 <- select(State_White_15, MHI_White, Year)


#Combine all datasets
State_All <- rbind(State_All_09, State_All_10, State_All_11, State_All_12, State_All_13, State_All_14, State_All_15)
State_Asian <- rbind(State_Asian_09, State_Asian_10, State_Asian_11, State_Asian_12, State_Asian_13, State_Asian_14, State_Asian_15)
State_Black <- rbind(State_Black_09, State_Black_10, State_Black_11, State_Black_12, State_Black_13, State_Black_14, State_Black_15)
State_Hispanic <- rbind(State_Hispanic_09, State_Hispanic_10, State_Hispanic_11, State_Hispanic_12, State_Hispanic_13, State_Hispanic_14, State_Hispanic_15)
State_White <- rbind(State_White_09, State_White_10, State_White_11, State_White_12, State_White_13, State_White_14, State_White_15)


#Table Joins
State_All_Asian <- merge(x = State_All, y = State_Asian, by = "Year", all.x = TRUE)
State_All_Asian_Black <- merge(x = State_All_Asian, y = State_Black, by = "Year", all.x = TRUE)
State_All_Asian_Black_Hispanic <- merge(x = State_All_Asian_Black, y = State_Hispanic, by = "Year", all.x = TRUE)
State_MHI_Race <- merge(x = State_All_Asian_Black_Hispanic, y = State_White, by = "Year", all.x = TRUE)

# Convert MHI to numeric
State_MHI_Race <- transform(State_MHI_Race, 
                           MHI_ALL = as.numeric(MHI_ALL),
                           MHI_Asian = as.numeric(MHI_Asian),
                           MHI_Black = as.numeric(MHI_Black),
                           MHI_Hispanic = as.numeric(MHI_Hispanic),
                           MHI_White = as.numeric(MHI_White))
              

#Write to CSV
write.csv(State_MHI_Race, file = "State_MHI_Race.csv", row.names = FALSE)


# Income by Age
# Import Income data for age
State_Age_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_09_5YR_B19049_with_ann.csv")
State_Age_10 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_10_5YR_B19049_with_ann.csv")
State_Age_11 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_11_5YR_B19049_with_ann.csv")
State_Age_12 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_12_5YR_B19049_with_ann.csv")
State_Age_13 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_13_5YR_B19049_with_ann.csv")
State_Age_14 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_14_5YR_B19049_with_ann.csv")
State_Age_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_AGE/ACS_15_5YR_B19049_with_ann.csv")


# Remove annotation
State_Age_09 <- State_Age_09[-1,]
State_Age_10 <- State_Age_10[-1,]
State_Age_11 <- State_Age_11[-1,]
State_Age_12 <- State_Age_12[-1,]
State_Age_13 <- State_Age_13[-1,]
State_Age_14 <- State_Age_14[-1,]
State_Age_15 <- State_Age_15[-1,]

#Rename attributes
State_Age_09 <- rename(State_Age_09, MHI_ALL = HD01_VD02, MHI_U25 = HD01_VD03, MHI_25_44 = HD01_VD04, MHI_45_64 = HD01_VD05, MHI_65P = HD01_VD06)
State_Age_10 <- rename(State_Age_10, MHI_ALL = HD01_VD02, MHI_U25 = HD01_VD03, MHI_25_44 = HD01_VD04, MHI_45_64 = HD01_VD05, MHI_65P = HD01_VD06)
State_Age_11 <- rename(State_Age_11, MHI_ALL = HD01_VD02, MHI_U25 = HD01_VD03, MHI_25_44 = HD01_VD04, MHI_45_64 = HD01_VD05, MHI_65P = HD01_VD06)
State_Age_12 <- rename(State_Age_12, MHI_ALL = HD01_VD02, MHI_U25 = HD01_VD03, MHI_25_44 = HD01_VD04, MHI_45_64 = HD01_VD05, MHI_65P = HD01_VD06)
State_Age_13 <- rename(State_Age_13, MHI_ALL = HD01_VD02, MHI_U25 = HD01_VD03, MHI_25_44 = HD01_VD04, MHI_45_64 = HD01_VD05, MHI_65P = HD01_VD06)
State_Age_14 <- rename(State_Age_14, MHI_ALL = HD01_VD02, MHI_U25 = HD01_VD03, MHI_25_44 = HD01_VD04, MHI_45_64 = HD01_VD05, MHI_65P = HD01_VD06)
State_Age_15 <- rename(State_Age_15, MHI_ALL = HD01_VD02, MHI_U25 = HD01_VD03, MHI_25_44 = HD01_VD04, MHI_45_64 = HD01_VD05, MHI_65P = HD01_VD06)

#Add year to each dataset
State_Age_09 <- mutate(State_Age_09, Year = 2009)
State_Age_10 <- mutate(State_Age_10, Year = 2010)
State_Age_11 <- mutate(State_Age_11, Year = 2011)
State_Age_12 <- mutate(State_Age_12, Year = 2012)
State_Age_13 <- mutate(State_Age_13, Year = 2013)
State_Age_14 <- mutate(State_Age_14, Year = 2014)
State_Age_15 <- mutate(State_Age_15, Year = 2015)    


#Select MHIs and Year
State_Age_09 <- select(State_Age_09, MHI_ALL, MHI_U25, MHI_25_44, MHI_45_64, MHI_65P, Year)
State_Age_10 <- select(State_Age_10, MHI_ALL, MHI_U25, MHI_25_44, MHI_45_64, MHI_65P, Year)
State_Age_11 <- select(State_Age_11, MHI_ALL, MHI_U25, MHI_25_44, MHI_45_64, MHI_65P, Year)
State_Age_12 <- select(State_Age_12, MHI_ALL, MHI_U25, MHI_25_44, MHI_45_64, MHI_65P, Year)
State_Age_13 <- select(State_Age_13, MHI_ALL, MHI_U25, MHI_25_44, MHI_45_64, MHI_65P, Year)
State_Age_14 <- select(State_Age_14, MHI_ALL, MHI_U25, MHI_25_44, MHI_45_64, MHI_65P, Year)
State_Age_15 <- select(State_Age_15, MHI_ALL, MHI_U25, MHI_25_44, MHI_45_64, MHI_65P, Year)


#Combine all datasets
State_MHI_Age <- rbind(State_Age_09, State_Age_10, State_Age_11, State_Age_12, State_Age_13, State_Age_14, State_Age_15)

# Convert MHI to numeric
State_MHI_Age <- transform(State_MHI_Age, 
                            MHI_ALL = as.numeric(MHI_ALL),
                            MHI_U25 = as.numeric(MHI_U25),
                            MHI_25_44 = as.numeric(MHI_25_44),
                            MHI_45_64 = as.numeric(MHI_45_64),
                            MHI_65P = as.numeric(MHI_65P))

#Write to CSV
write.csv(State_MHI_Age, file = "State_MHI_Age.csv", row.names = FALSE)


# Income by Sex, Non Family Households
# Import Income data for Race
State_Sex_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_09_5YR_B19215_with_ann.csv")
State_Sex_10 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_10_5YR_B19215_with_ann.csv")
State_Sex_11 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_11_5YR_B19215_with_ann.csv")
State_Sex_12 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_12_5YR_B19215_with_ann.csv")
State_Sex_13 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_13_5YR_B19215_with_ann.csv")
State_Sex_14 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_14_5YR_B19215_with_ann.csv")
State_Sex_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/State/Median_Household_Income_Sex/ACS_15_5YR_B19215_with_ann.csv")

# Remove Annotations row
State_Sex_09 <- State_Sex_09[-1,]
State_Sex_10 <- State_Sex_10[-1,]
State_Sex_11 <- State_Sex_11[-1,]
State_Sex_12 <- State_Sex_12[-1,]
State_Sex_13 <- State_Sex_13[-1,]
State_Sex_14 <- State_Sex_14[-1,]
State_Sex_15 <- State_Sex_15[-1,]


#Rename attributes
State_Sex_09 <- rename(State_Sex_09, MHI_ALL = HD01_VD02, MHI_Male = HD01_VD04, MHI_Female = HD01_VD14)
State_Sex_10 <- rename(State_Sex_10, MHI_ALL = HD01_VD02, MHI_Male = HD01_VD04, MHI_Female = HD01_VD14)
State_Sex_11 <- rename(State_Sex_11, MHI_ALL = HD01_VD02, MHI_Male = HD01_VD04, MHI_Female = HD01_VD14)
State_Sex_12 <- rename(State_Sex_12, MHI_ALL = HD01_VD02, MHI_Male = HD01_VD04, MHI_Female = HD01_VD14)
State_Sex_13 <- rename(State_Sex_13, MHI_ALL = HD01_VD02, MHI_Male = HD01_VD04, MHI_Female = HD01_VD14)
State_Sex_14 <- rename(State_Sex_14, MHI_ALL = HD01_VD02, MHI_Male = HD01_VD04, MHI_Female = HD01_VD14)
State_Sex_15 <- rename(State_Sex_15, MHI_ALL = HD01_VD02, MHI_Male = HD01_VD04, MHI_Female = HD01_VD14)


#Add year to each dataset
State_Sex_09 <- mutate(State_Sex_09, Year = 2009)
State_Sex_10 <- mutate(State_Sex_10, Year = 2010)
State_Sex_11 <- mutate(State_Sex_11, Year = 2011)
State_Sex_12 <- mutate(State_Sex_12, Year = 2012)
State_Sex_13 <- mutate(State_Sex_13, Year = 2013)
State_Sex_14 <- mutate(State_Sex_14, Year = 2014)
State_Sex_15 <- mutate(State_Sex_15, Year = 2015)  


#Select MHIs and Year
State_Sex_09 <- select(State_Sex_09, Year, MHI_ALL, MHI_Male, MHI_Female)
State_Sex_10 <- select(State_Sex_10, Year, MHI_ALL, MHI_Male, MHI_Female)
State_Sex_11 <- select(State_Sex_11, Year, MHI_ALL, MHI_Male, MHI_Female)
State_Sex_12 <- select(State_Sex_12, Year, MHI_ALL, MHI_Male, MHI_Female)
State_Sex_13 <- select(State_Sex_13, Year, MHI_ALL, MHI_Male, MHI_Female)
State_Sex_14 <- select(State_Sex_14, Year, MHI_ALL, MHI_Male, MHI_Female)
State_Sex_15 <- select(State_Sex_15, Year, MHI_ALL, MHI_Male, MHI_Female)


#Combine all datasets
State_MHI_Sex <- rbind(State_Sex_09, State_Sex_10, State_Sex_11, State_Sex_12, State_Sex_13, State_Sex_14, State_Sex_15)

# Convert MHI to numeric
State_MHI_Sex <- transform(State_MHI_Sex, 
                           MHI_ALL = as.numeric(MHI_ALL),
                           MHI_Male = as.numeric(MHI_Male),
                           MHI_Female = as.numeric(MHI_Female))

#Write to CSV
write.csv(State_MHI_Sex, file = "State_MHI_Sex.csv", row.names = FALSE)


#Census Tract Income by Race
CT_All_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income/ACS_09_5YR_B19013_with_ann.csv")
CT_All_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income/ACS_15_5YR_B19013_with_ann.csv")

CT_Asian_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income_Asian/ACS_09_5YR_B19013D_with_ann.csv")
CT_Asian_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income_Asian/ACS_15_5YR_B19013D_with_ann.csv")

CT_Black_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income_Black/ACS_09_5YR_B19013B_with_ann.csv")
CT_Black_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income_Black/ACS_15_5YR_B19013B_with_ann.csv")

CT_Hispanic_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income_Hispanic/ACS_09_5YR_B19013I_with_ann.csv")
CT_Hispanic_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income_Hispanic/ACS_15_5YR_B19013I_with_ann.csv")

CT_White_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income_White/ACS_09_5YR_B19013A_with_ann.csv")
CT_White_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income_White/ACS_15_5YR_B19013A_with_ann.csv")


# Remove Annotations row
CT_All_09 <- CT_All_09[-1,]
CT_All_15 <- CT_All_15[-1,]

CT_Asian_09 <- CT_Asian_09[-1,]
CT_Asian_15 <- CT_Asian_15[-1,]

CT_Black_09 <- CT_Black_09[-1,]
CT_Black_15 <- CT_Black_15[-1,]

CT_Hispanic_09 <- CT_Hispanic_09[-1,]
CT_Hispanic_15 <- CT_Hispanic_15[-1,]

CT_White_09 <- CT_White_09[-1,]
CT_White_15 <- CT_White_15[-1,]

# Replace ** rows with NA
CT_All_09 <- as.data.frame(sapply(CT_All_09, sub, pattern = '-', replacement = NA))
CT_All_15 <- as.data.frame(sapply(CT_All_15, sub, pattern = '-', replacement = NA))

CT_Asian_09 <- as.data.frame(sapply(CT_Asian_09, sub, pattern = '-', replacement = NA))
CT_Asian_15 <- as.data.frame(sapply(CT_Asian_15, sub, pattern = '-', replacement = NA))

CT_Black_09 <- as.data.frame(sapply(CT_Black_09, sub, pattern = '-', replacement = NA))
CT_Black_15 <- as.data.frame(sapply(CT_Black_15, sub, pattern = '-', replacement = NA))

CT_Hispanic_09 <- as.data.frame(sapply(CT_Hispanic_09, sub, pattern = '-', replacement = NA))
CT_Hispanic_15 <- as.data.frame(sapply(CT_Hispanic_15, sub, pattern = '-', replacement = NA))

CT_White_09 <- as.data.frame(sapply(CT_White_09, sub, pattern = '-', replacement = NA))
CT_White_15 <- as.data.frame(sapply(CT_White_15, sub, pattern = '-', replacement = NA))


#Rename attributes
CT_All_09 <- rename(CT_All_09, GEOID = GEO.id2, MHI_ALL_09 = HD01_VD01)
CT_All_15 <- rename(CT_All_15, GEOID = GEO.id2, MHI_ALL_15 = HD01_VD01)

CT_Asian_09 <- rename(CT_Asian_09, GEOID = GEO.id2, MHI_Asian_09 = HD01_VD01)
CT_Asian_15 <- rename(CT_Asian_15, GEOID = GEO.id2, MHI_Asian_15 = HD01_VD01)

CT_Black_09 <- rename(CT_Black_09, GEOID = GEO.id2, MHI_Black_09 = HD01_VD01)
CT_Black_15 <- rename(CT_Black_15, GEOID = GEO.id2, MHI_Black_15 = HD01_VD01)

CT_Hispanic_09 <- rename(CT_Hispanic_09, GEOID = GEO.id2, MHI_Hispanic_09 = HD01_VD01)
CT_Hispanic_15 <- rename(CT_Hispanic_15, GEOID = GEO.id2, MHI_Hispanic_15 = HD01_VD01)

CT_White_09 <- rename(CT_White_09, GEOID = GEO.id2, MHI_White_09 = HD01_VD01)
CT_White_15 <- rename(CT_White_15, GEOID = GEO.id2, MHI_White_15 = HD01_VD01)

#Select MHI and GEOID
CT_All_09 <- select(CT_All_09, GEOID, MHI_ALL_09)
CT_All_15 <- select(CT_All_15, GEOID, MHI_ALL_15)

CT_Asian_09 <- select(CT_Asian_09, GEOID, MHI_Asian_09)
CT_Asian_15 <- select(CT_Asian_15, GEOID, MHI_Asian_15)

CT_Black_09 <- select(CT_Black_09, GEOID, MHI_Black_09)
CT_Black_15 <- select(CT_Black_15, GEOID, MHI_Black_15)

CT_Hispanic_09 <- select(CT_Hispanic_09, GEOID, MHI_Hispanic_09)
CT_Hispanic_15 <- select(CT_Hispanic_15, GEOID, MHI_Hispanic_15)

CT_White_09 <- select(CT_White_09, GEOID, MHI_White_09)
CT_White_15 <- select(CT_White_15, GEOID, MHI_White_15)


#Table Joins
CT_1 <- merge(x = CT_Hispanic_09, y = CT_All_09, by = "GEOID", all.x = TRUE)
CT_2 <- merge(x = CT_1, y = CT_All_15, by = "GEOID", all.x = TRUE)
CT_3 <- merge(x = CT_2, y = CT_Black_09, by = "GEOID", all.x = TRUE)
CT_4 <- merge(x = CT_3, y = CT_Black_15, by = "GEOID", all.x = TRUE)
CT_5 <- merge(x = CT_4, y = CT_White_09, by = "GEOID", all.x = TRUE)
CT_6 <- merge(x = CT_5, y = CT_White_15, by = "GEOID", all.x = TRUE)
CT_7 <- merge(x = CT_6, y = CT_Hispanic_15, by = "GEOID", all.x = TRUE)
CT_8 <- merge(x = CT_7, y = CT_Asian_09, by = "GEOID", all.x = TRUE)
CT_MHI_Race <- merge(x = CT_8, y = CT_Asian_15, by = "GEOID", all.x = TRUE)


#Convert MHI to numberic and GEOID to string
CT_MHI_Race <- transform(CT_MHI_Race,
                           GEOID = as.character(GEOID),
                           MHI_ALL_09 = as.numeric(MHI_ALL_09),
                           MHI_ALL_15 = as.numeric(MHI_ALL_15),
                           MHI_Asian_09 = as.numeric(MHI_Asian_09),
                           MHI_Asian_15 = as.numeric(MHI_Asian_15),
                           MHI_Black_09 = as.numeric(MHI_Black_09),
                           MHI_Black_15 = as.numeric(MHI_Black_15),
                           MHI_Hispanic_09 = as.numeric(MHI_Hispanic_09),
                           MHI_Hispanic_15 = as.numeric(MHI_Hispanic_15),
                           MHI_White_09 = as.numeric(MHI_White_09),
                           MHI_White_15 = as.numeric(MHI_White_15)
                           )

#Calculate Percent Increase or Decrease
CT_MHI_Race <- mutate(CT_MHI_Race,
                      MHI_ALL_Change = (MHI_ALL_15 - MHI_ALL_09) / MHI_ALL_09 * 100,
                      MHI_Asian_Change = (MHI_Asian_15 - MHI_Asian_09) / MHI_Asian_09 * 100,
                      MHI_Black_Change = (MHI_Black_15 - MHI_Black_09) / MHI_Black_09 * 100,
                      MHI_Hispanic_Change = (MHI_Hispanic_15 - MHI_Hispanic_09) / MHI_Hispanic_09 * 100,
                      MHI_White_Change = (MHI_White_15 - MHI_White_09) / MHI_White_09 * 100
                      )

write.xlsx(CT_MHI_Race, file = "CT_MHI_Race.xlsx",
           sheetName = "CT_MHI_Race",
           row.names = FALSE)




# Census Tracts Income by Age
# Import Income data for age
CT_Age_09 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income_Age/ACS_09_5YR_B19049_with_ann.csv")
CT_Age_15 <- read_csv("G:/DC Policy Center/Income Growth/Data/Tab/Census_Tract/Median_Household_Income_Age/ACS_15_5YR_B19049_with_ann.csv")


# Remove annotation
CT_Age_09 <- CT_Age_09[-1,]
CT_Age_15 <- CT_Age_15[-1,]

# Replace ** rows with NA
CT_Age_09 <- as.data.frame(sapply(CT_Age_09, sub, pattern = '-', replacement = NA))
CT_Age_15 <- as.data.frame(sapply(CT_Age_15, sub, pattern = '-', replacement = NA))


#Rename attributes
CT_Age_09 <- rename(CT_Age_09, GEOID = GEO.id2, MHI_ALL_09 = HD01_VD02, MHI_U25_09 = HD01_VD03, MHI_25_44_09 = HD01_VD04, MHI_45_64_09 = HD01_VD05, MHI_65P_09 = HD01_VD06)
CT_Age_15 <- rename(CT_Age_15, GEOID = GEO.id2, MHI_ALL_15 = HD01_VD02, MHI_U25_15 = HD01_VD03, MHI_25_44_15 = HD01_VD04, MHI_45_64_15 = HD01_VD05, MHI_65P_15 = HD01_VD06)


#Select MHIs and GEOID
CT_Age_09 <- select(CT_Age_09, GEOID, MHI_ALL_09, MHI_U25_09, MHI_25_44_09, MHI_45_64_09, MHI_65P_09)
CT_Age_15 <- select(CT_Age_15, GEOID, MHI_ALL_15, MHI_U25_15, MHI_25_44_15, MHI_45_64_15, MHI_65P_15)

#Table Joins
CT_MHI_Age <- merge(x = CT_Age_09, y = CT_Age_15, by = "GEOID", all.x = TRUE)


#Convert MHI to numberic and GEOID to string
CT_MHI_Age <- transform(CT_MHI_Age,
                         GEOID = as.character(GEOID),
                         MHI_ALL_09 = as.numeric(MHI_ALL_09),
                         MHI_ALL_15 = as.numeric(MHI_ALL_15),
                         MHI_U25_09 = as.numeric(MHI_U25_09),
                         MHI_U25_15 = as.numeric(MHI_U25_15),
                         MHI_25_44_09 = as.numeric(MHI_25_44_09),
                         MHI_25_44_15 = as.numeric(MHI_25_44_15),
                         MHI_45_64_09 = as.numeric(MHI_45_64_09),
                         MHI_45_64_15 = as.numeric(MHI_45_64_15),
                         MHI_65P_09 = as.numeric(MHI_65P_09),
                         MHI_65P_15 = as.numeric(MHI_65P_15)
                         )


#Calculate Percent Increase or Decrease
CT_MHI_Age <- mutate(CT_MHI_Age,
                      MHI_ALL_Change = (MHI_ALL_15 - MHI_ALL_09) / MHI_ALL_09 * 100,
                      MHI_U25_Change = (MHI_U25_15 - MHI_U25_09) / MHI_Asian_09 * 100,
                      MHI_25_44_Change = (MHI_25_44_15 - MHI_25_44_09) / MHI_25_44_09 * 100,
                      MHI_45_64_Change = (MHI_45_64_15 - MHI_45_64_09) / MHI_45_64_09 * 100,
                      MHI_65P_Change = ( MHI_65P_15 -  MHI_65P_09) /  MHI_65P_09 * 100
)


write.xlsx(CT_MHI_Age, file = "CT_MHI_Age.xlsx",
           sheetName = "CT_MHI_Age",
           row.names = FALSE)
                   