# Analysis for Fertility rate in Washington D.C.
# For: D.C. Policy Center
# Author: Randy Smith

library("xlsx")
library(hrbrthemes)
library(gcookbook)
library(tidyverse)

#----------------------------------------------------------------------------------------------------------------------------------------------------------
# Load Data, clean up, reformat, and calculate birth rates per census tract
f_2015 <- read.csv("G:/DC Policy Center/Fertility/Data/Tab/Fetility/ACS_15_5YR_S1301_with_ann.csv")

# Removes annotation row
f_2015 = f_2015[-1,]

# Reformating
f_2015 <- f_2015 %>% 

# Selecting needed data form df
select(GEO.id2,
       HC01_EST_VC01,
       HC02_EST_VC01,
       HC01_EST_VC02,
       HC02_EST_VC02,
       HC01_EST_VC03,
       HC02_EST_VC03,
       HC01_EST_VC04,
       HC02_EST_VC04) %>% 
  
# renaming to relavent column names  
  rename(GEOID = GEO.id2,
            Total = HC01_EST_VC01,
            total_births = HC02_EST_VC01,
            total_1519 = HC01_EST_VC02,
            births_1519 = HC02_EST_VC02,
            total_2034 = HC01_EST_VC03,
            births_2034 = HC02_EST_VC03,
            total_3550 = HC01_EST_VC04,
           births_3550 = HC02_EST_VC04) %>% 

# Adding year of dataset  
  mutate(Year = 2015)

# Writing dataset to master xlsx
write.xlsx(f_2015, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2015",
           row.names = FALSE)

# Reloading df to remove columns as factors
f_2015 <- read.xlsx("G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx", sheetName = "f_2015", stringsAsFactors=FALSE) %>%
  
# Change data to numeric
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000)

# rewrite to master xlsx workbook
write.xlsx(f_2015, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2015",
           row.names = FALSE)

f_2014 <- read.csv("G:/DC Policy Center/Fertility/Data/Tab/Fetility/ACS_14_5YR_S1301_with_ann.csv")
f_2014 = f_2014[-1,]
f_2014 <- f_2014 %>% 
  select(GEO.id2,
         HC01_EST_VC01,
         HC02_EST_VC01,
         HC01_EST_VC02,
         HC02_EST_VC02,
         HC01_EST_VC03,
         HC02_EST_VC03,
         HC01_EST_VC04,
         HC02_EST_VC04) %>% 
  rename(GEOID = GEO.id2,
         Total = HC01_EST_VC01,
         total_births = HC02_EST_VC01,
         total_1519 = HC01_EST_VC02,
         births_1519 = HC02_EST_VC02,
         total_2034 = HC01_EST_VC03,
         births_2034 = HC02_EST_VC03,
         total_3550 = HC01_EST_VC04,
         births_3550 = HC02_EST_VC04) %>% 
  mutate(Year = 2014)
write.xlsx(f_2014, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2014",
           row.names = FALSE,
           append = TRUE)
f_2014 <- read.xlsx("G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx", sheetName = "f_2014", stringsAsFactors=FALSE)%>%
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000)
write.xlsx(f_2014, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2014",
           row.names = FALSE,
           append = TRUE)

f_2013 <- read.csv("G:/DC Policy Center/Fertility/Data/Tab/Fetility/ACS_13_5YR_S1301_with_ann.csv")
f_2013 = f_2013[-1,]
f_2013 <- f_2013 %>% 
  select(GEO.id2,
         HC01_EST_VC01,
         HC02_EST_VC01,
         HC01_EST_VC02,
         HC02_EST_VC02,
         HC01_EST_VC03,
         HC02_EST_VC03,
         HC01_EST_VC04,
         HC02_EST_VC04) %>% 
  rename(GEOID = GEO.id2,
         Total = HC01_EST_VC01,
         total_births = HC02_EST_VC01,
         total_1519 = HC01_EST_VC02,
         births_1519 = HC02_EST_VC02,
         total_2034 = HC01_EST_VC03,
         births_2034 = HC02_EST_VC03,
         total_3550 = HC01_EST_VC04,
         births_3550 = HC02_EST_VC04) %>% 
  mutate(Year = 2013)
write.xlsx(f_2013, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2013",
           row.names = FALSE,
           append = TRUE) 
f_2013 <- read.xlsx("G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx", sheetName = "f_2013", stringsAsFactors=FALSE)%>%
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000)
write.xlsx(f_2013, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2013",
           row.names = FALSE,
           append = TRUE)

f_2012 <- read.csv("G:/DC Policy Center/Fertility/Data/Tab/Fetility/ACS_12_5YR_S1301_with_ann.csv")
f_2012 = f_2012[-1,]
f_2012 <- f_2012 %>% 
  select(GEO.id2,
         HC01_EST_VC01,
         HC02_EST_VC01,
         HC01_EST_VC02,
         HC02_EST_VC02,
         HC01_EST_VC03,
         HC02_EST_VC03,
         HC01_EST_VC04,
         HC02_EST_VC04) %>% 
  rename(GEOID = GEO.id2,
         Total = HC01_EST_VC01,
         total_births = HC02_EST_VC01,
         total_1519 = HC01_EST_VC02,
         births_1519 = HC02_EST_VC02,
         total_2034 = HC01_EST_VC03,
         births_2034 = HC02_EST_VC03,
         total_3550 = HC01_EST_VC04,
         births_3550 = HC02_EST_VC04) %>% 
  mutate(Year = 2012)
write.xlsx(f_2012, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2012",
           row.names = FALSE,
           append = TRUE)
f_2012 <- read.xlsx("G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx", sheetName = "f_2012", stringsAsFactors = FALSE) %>%
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000)
write.xlsx(f_2012, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2012",
           row.names = FALSE,
           append = TRUE)

f_2011 <- read.csv("G:/DC Policy Center/Fertility/Data/Tab/Fetility/ACS_11_5YR_S1301_with_ann.csv")
f_2011 = f_2011[-1,]
f_2011 <- f_2011 %>% 
  select(GEO.id2,
         HC01_EST_VC01,
         HC02_EST_VC01,
         HC01_EST_VC02,
         HC02_EST_VC02,
         HC01_EST_VC03,
         HC02_EST_VC03,
         HC01_EST_VC04,
         HC02_EST_VC04) %>% 
  rename(GEOID = GEO.id2,
         Total = HC01_EST_VC01,
         total_births = HC02_EST_VC01,
         total_1519 = HC01_EST_VC02,
         births_1519 = HC02_EST_VC02,
         total_2034 = HC01_EST_VC03,
         births_2034 = HC02_EST_VC03,
         total_3550 = HC01_EST_VC04,
         births_3550 = HC02_EST_VC04) %>% 
  mutate(Year = 2011)
write.xlsx(f_2011, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2011",
           row.names = FALSE,
           append = TRUE)
f_2011 <- read.xlsx("G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx", sheetName = "f_2011", stringsAsFactors=FALSE) %>%
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000)
write.xlsx(f_2011, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2011",
           row.names = FALSE,
           append = TRUE)

f_2010 <- read.csv("G:/DC Policy Center/Fertility/Data/Tab/Fetility/ACS_10_5YR_S1301_with_ann.csv")
f_2010 = f_2010[-1,]
f_2010 <- f_2010 %>% 
  select(GEO.id2,
         HC01_EST_VC01,
         HC02_EST_VC01,
         HC01_EST_VC02,
         HC02_EST_VC02,
         HC01_EST_VC03,
         HC02_EST_VC03,
         HC01_EST_VC04,
         HC02_EST_VC04) %>% 
  rename(GEOID = GEO.id2,
         Total = HC01_EST_VC01,
         total_births = HC02_EST_VC01,
         total_1519 = HC01_EST_VC02,
         births_1519 = HC02_EST_VC02,
         total_2034 = HC01_EST_VC03,
         births_2034 = HC02_EST_VC03,
         total_3550 = HC01_EST_VC04,
         births_3550 = HC02_EST_VC04) %>% 
  mutate(Year = 2010)
write.xlsx(f_2010, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2010",
           row.names = FALSE,
           append = TRUE)
f_2010 <- read.xlsx("G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx", sheetName = "f_2010", stringsAsFactors=FALSE) %>%
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000)
write.xlsx(f_2010, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2010",
           row.names = FALSE,
           append = TRUE)

f_2009 <- read.csv("G:/DC Policy Center/Fertility/Data/Tab/Fetility/ACS_09_5YR_S1301_with_ann.csv")
f_2009 = f_2009[-1,]
f_2009 <- f_2009 %>% 
  select(GEO.id2,
         HC01_EST_VC01,
         HC03_EST_VC01,
         HC01_EST_VC02,
         HC03_EST_VC02,
         HC01_EST_VC03,
         HC03_EST_VC03,
         HC01_EST_VC04,
         HC03_EST_VC04) %>% 
  rename(GEOID = GEO.id2,
         Total = HC01_EST_VC01,
         total_births = HC03_EST_VC01,
         total_1519 = HC01_EST_VC02,
         births_1519 = HC03_EST_VC02,
         total_2034 = HC01_EST_VC03,
         births_2034 = HC03_EST_VC03,
         total_3550 = HC01_EST_VC04,
         births_3550 = HC03_EST_VC04) %>% 
  mutate(Year = 2009)
write.xlsx(f_2009, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2009",
           row.names = FALSE,
           append = TRUE)
f_2009 <- read.xlsx("G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx", sheetName = "f_2009", stringsAsFactors=FALSE) %>%
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000)
write.xlsx(f_2009, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/fertility.xlsx",
           sheetName = "f_2009",
           row.names = FALSE,
           append = TRUE)


#----------------------------------------------------------------------------------------------------------------------------------------------------
# Calculate summary counts for D.C. from 2009 to 2015. Summary counts include birth rates for overall and age groups 15-19, 20-34, and 35-50
f_2015_line <- f_2015 %>%
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  count(Year = mean(Year),
        Total = sum(Total),
        total_births = sum(total_births),
        total_1519 = sum(total_1519),
        births_1519 = sum(births_1519),
        total_2034 = sum(total_2034),
        births_2034 = sum(births_2034),
        total_3550 = sum(total_3550),
        births_3550 = sum(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000) %>% 
  gather(`rate_all`, `rate_1519`, `rate_2034`, `rate_3550`, key = type, value = Births)

f_2014_line <- f_2014 %>%
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  count(Year = mean(Year),
        Total = sum(Total),
        total_births = sum(total_births),
        total_1519 = sum(total_1519),
        births_1519 = sum(births_1519),
        total_2034 = sum(total_2034),
        births_2034 = sum(births_2034),
        total_3550 = sum(total_3550),
        births_3550 = sum(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000) %>% 
gather(`rate_all`, `rate_1519`, `rate_2034`, `rate_3550`, key = type, value = Births)

f_2013_line <- f_2013 %>% 
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  count(Year = mean(Year),
        Total = sum(Total),
        total_births = sum(total_births),
        total_1519 = sum(total_1519),
        births_1519 = sum(births_1519),
        total_2034 = sum(total_2034),
        births_2034 = sum(births_2034),
        total_3550 = sum(total_3550),
        births_3550 = sum(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000) %>% 
gather(`rate_all`, `rate_1519`, `rate_2034`, `rate_3550`, key = type, value = Births)

f_2012_line <- f_2012 %>% 
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  count(Year = mean(Year),
        Total = sum(Total),
        total_births = sum(total_births),
        total_1519 = sum(total_1519),
        births_1519 = sum(births_1519),
        total_2034 = sum(total_2034),
        births_2034 = sum(births_2034),
        total_3550 = sum(total_3550),
        births_3550 = sum(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000) %>% 
gather(`rate_all`, `rate_1519`, `rate_2034`, `rate_3550`, key = type, value = Births)

f_2011_line <- f_2011 %>% 
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  count(Year = mean(Year),
        Total = sum(Total),
        total_births = sum(total_births),
        total_1519 = sum(total_1519),
        births_1519 = sum(births_1519),
        total_2034 = sum(total_2034),
        births_2034 = sum(births_2034),
        total_3550 = sum(total_3550),
        births_3550 = sum(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000) %>% 
gather(`rate_all`, `rate_1519`, `rate_2034`, `rate_3550`, key = type, value = Births)

f_2010_line <- f_2010 %>% 
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  count(Year = mean(Year),
        Total = sum(Total),
        total_births = sum(total_births),
        total_1519 = sum(total_1519),
        births_1519 = sum(births_1519),
        total_2034 = sum(total_2034),
        births_2034 = sum(births_2034),
        total_3550 = sum(total_3550),
        births_3550 = sum(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000) %>% 
gather(`rate_all`, `rate_1519`, `rate_2034`, `rate_3550`, key = type, value = Births)

f_2009_line <- f_2009 %>%
  transform(Year = as.numeric(Year),
            Total = as.numeric(Total),
            total_births = as.numeric(total_births),
            total_1519 = as.numeric(total_1519),
            births_1519 = as.numeric(births_1519),
            total_2034 = as.numeric(total_2034),
            births_2034 = as.numeric(births_2034),
            total_3550 = as.numeric(total_3550),
            births_3550 = as.numeric(births_3550)) %>% 
  count(Year = mean(Year),
        Total = sum(Total),
        total_births = sum(total_births),
        total_1519 = sum(total_1519),
        births_1519 = sum(births_1519),
        total_2034 = sum(total_2034),
        births_2034 = sum(births_2034),
        total_3550 = sum(total_3550),
        births_3550 = sum(births_3550)) %>% 
  mutate(rate_all = total_births / Total * 1000,
         rate_1519 = births_1519 / total_1519 * 1000,
         rate_2034 = births_2034 / total_2034 * 1000,
         rate_3550 = births_3550 / total_3550 * 1000) %>% 
gather(`rate_all`, `rate_1519`, `rate_2034`, `rate_3550`, key = type, value = Births)

# Bind all summary counts together
fertility_sum <- rbind(f_2009_line, f_2010_line, f_2011_line, f_2012_line, f_2013_line, f_2014_line, f_2015_line) %>% 
  group_by(type) %>% 
  arrange(desc(type))


# set color scheme and legend labels
col <- c("#527394", "#8BCFC5", "#B16379", "#E8272C")
demo <- c("Women 15 to 19", "Women 20 to 34", "Women 35 to 50", "Overall")

# Create line graph for birth rates from 2009 to 2015
ggplot(fertility_sum, aes(x = Year, y = Births, color = type)) +
  geom_smooth(size = 1, se = FALSE) +
  scale_colour_manual(labels = demo, values = col) +
  ylim(c(0,65)) +
  scale_x_continuous(breaks = round(seq(min(2009), max(2015), by = 1),1)) +
  labs(color = "Age Ranges",
       x = "Year", y = "Birth Rate per 1000",
       title = "Birth rates in D.C. have fallen since 2009",
       subtitle = "Birth rates in Washington, D.C., 2009 - 2015",
       caption = "Source: American Community Survey, 2009 - 2015") + 
  theme_ipsum_rc()


#---------------------------------------------------------------------------------------
# Aggregate data to neighbohood resolution and clean for D3js bargraph

ct_data <- read.csv("G:/DC Policy Center/Fertility/Data/Tab/ct_data.csv")

# Select relevant columns, sum counts, recalculate birth rates, calculate 
# percent change in birth rate, select only top 10 neighborhoods
ct_data <- ct_data %>% 
  select(Census_Tract_N_Name,
         Census_Tract_N_Cluster,
         CT_EA_Income__C_Bach,
         b_rate_change_3550,
         birth_rate_change,
         CT_EA_Income__C_Income,
         Total_2015,
         Total_2009,
         total_births_2015,
         total_births_2009) %>% 
  group_by(Census_Tract_N_Name) %>% 
  summarise(Total_2015 = sum(Total_2015),
            Total_2009 = sum(Total_2009),
            total_births_2015 = sum(total_births_2015),
            total_births_2009 = sum(total_births_2009),
            br_2015 = total_births_2015 / Total_2015 * 1000,
            br_2009 = total_births_2009 / Total_2009 * 1000,
            Change = (br_2015 - br_2009) / br_2009 * 100) %>% 
  filter(Change >= 81 & Change <= 620) %>% 
  arrange(desc(Change)) %>% 
  rename(name = Census_Tract_N_Name) %>% 
  select(name,
         Change,
         br_2015,
         br_2009)

# Write cleaned data frame to csv
write.csv(ct_data, file = "G:/DC Policy Center/Fertility/Data/Tab/Tidy/n_change.csv",
                     row.names = FALSE)


#-------------------------------------------------------------------------------------------------------
# Line Graphs going back to 2005

sf_2015 <- read_csv("G:/DC Policy Center/Fertility/Data/Tab/state_fertility/ACS_15_5YR_S1301_with_ann.csv")

# Removes annotation row
sf_2015 = sf_2015[-1,]

# Reformating
sf_2015 <- sf_2015 %>% 
  
  # Selecting needed data form df
  select(HC04_EST_VC01,
         HC04_EST_VC02,
         HC04_EST_VC03,
         HC04_EST_VC04,
         HC04_EST_VC09,
         HC04_EST_VC11,
         HC04_EST_VC16,
         HC04_EST_VC17,
         HC04_EST_VC24,
         HC04_EST_VC25,
         HC04_EST_VC26,
         HC04_EST_VC27,
         HC04_EST_VC28,
         HC04_EST_VC32,
         HC04_EST_VC33,
         HC04_EST_VC34) %>% 
  
  # renaming to relavent column names  
  rename(all = HC04_EST_VC01,
         w1519 = HC04_EST_VC02,
         w2034 = HC04_EST_VC03,
         w3550 = HC04_EST_VC04,
         black = HC04_EST_VC09,
         asian = HC04_EST_VC11,
         hispanic = HC04_EST_VC16,
         white = HC04_EST_VC17,
         nohs = HC04_EST_VC24,
         hs = HC04_EST_VC25,
         somecollege = HC04_EST_VC26,
         bach = HC04_EST_VC27,
         grad = HC04_EST_VC28,
         pbelow100 = HC04_EST_VC32,
         p100_199 = HC04_EST_VC33,
         p200plus = HC04_EST_VC34) %>% 
  
  # Adding year of dataset  
  mutate(Year = 2015) %>% 
  
  lapply(as.numeric) %>% 
  
  data.frame() %>%  
  
  gather(`all`, 
         `w1519`, 
         `w2034`, 
         `w3550`, 
         `black`, 
         `asian`, 
         `hispanic`, 
         `white`, 
         `nohs`,
         `hs`,
         `somecollege`,
         `bach`,
         `grad`,
         `pbelow100`,
         `p100_199`,
         `p200plus`,
         key = type, 
         value = Rate)

sf_2014 <- read_csv("G:/DC Policy Center/Fertility/Data/Tab/state_fertility/ACS_14_5YR_S1301_with_ann.csv")
sf_2014 = sf_2014[-1,]
sf_2014 <- sf_2014 %>% 
  select(HC04_EST_VC01,
         HC04_EST_VC02,
         HC04_EST_VC03,
         HC04_EST_VC04,
         HC04_EST_VC09,
         HC04_EST_VC11,
         HC04_EST_VC16,
         HC04_EST_VC17,
         HC04_EST_VC24,
         HC04_EST_VC25,
         HC04_EST_VC26,
         HC04_EST_VC27,
         HC04_EST_VC28,
         HC04_EST_VC32,
         HC04_EST_VC33,
         HC04_EST_VC34) %>%  
  rename(all = HC04_EST_VC01,
         w1519 = HC04_EST_VC02,
         w2034 = HC04_EST_VC03,
         w3550 = HC04_EST_VC04,
         black = HC04_EST_VC09,
         asian = HC04_EST_VC11,
         hispanic = HC04_EST_VC16,
         white = HC04_EST_VC17,
         nohs = HC04_EST_VC24,
         hs = HC04_EST_VC25,
         somecollege = HC04_EST_VC26,
         bach = HC04_EST_VC27,
         grad = HC04_EST_VC28,
         pbelow100 = HC04_EST_VC32,
         p100_199 = HC04_EST_VC33,
         p200plus = HC04_EST_VC34) %>% 
  mutate(Year = 2014) %>% 
  lapply(as.numeric) %>% 
  data.frame() %>%  
  gather(`all`, 
         `w1519`, 
         `w2034`, 
         `w3550`, 
         `black`, 
         `asian`, 
         `hispanic`, 
         `white`, 
         `nohs`,
         `hs`,
         `somecollege`,
         `bach`,
         `grad`,
         `pbelow100`,
         `p100_199`,
         `p200plus`,
         key = type, 
         value = Rate)

sf_2013 <- read_csv("G:/DC Policy Center/Fertility/Data/Tab/state_fertility/ACS_13_5YR_S1301_with_ann.csv")
sf_2013 = sf_2013[-1,]
sf_2013 <- sf_2013 %>% 
  select(HC04_EST_VC01,
         HC04_EST_VC02,
         HC04_EST_VC03,
         HC04_EST_VC04,
         HC04_EST_VC09,
         HC04_EST_VC11,
         HC04_EST_VC16,
         HC04_EST_VC17,
         HC04_EST_VC24,
         HC04_EST_VC25,
         HC04_EST_VC26,
         HC04_EST_VC27,
         HC04_EST_VC28,
         HC04_EST_VC32,
         HC04_EST_VC33,
         HC04_EST_VC34) %>%  
  rename(all = HC04_EST_VC01,
         w1519 = HC04_EST_VC02,
         w2034 = HC04_EST_VC03,
         w3550 = HC04_EST_VC04,
         black = HC04_EST_VC09,
         asian = HC04_EST_VC11,
         hispanic = HC04_EST_VC16,
         white = HC04_EST_VC17,
         nohs = HC04_EST_VC24,
         hs = HC04_EST_VC25,
         somecollege = HC04_EST_VC26,
         bach = HC04_EST_VC27,
         grad = HC04_EST_VC28,
         pbelow100 = HC04_EST_VC32,
         p100_199 = HC04_EST_VC33,
         p200plus = HC04_EST_VC34) %>% 
  mutate(Year = 2013) %>% 
  lapply(as.numeric) %>% 
  data.frame() %>%  
  gather(`all`, 
         `w1519`, 
         `w2034`, 
         `w3550`, 
         `black`, 
         `asian`, 
         `hispanic`, 
         `white`, 
         `nohs`,
         `hs`,
         `somecollege`,
         `bach`,
         `grad`,
         `pbelow100`,
         `p100_199`,
         `p200plus`,
         key = type, 
         value = Rate)

sf_2012 <- read_csv("G:/DC Policy Center/Fertility/Data/Tab/state_fertility/ACS_12_5YR_S1301_with_ann.csv")
sf_2012 = sf_2012[-1,]
sf_2012 <- sf_2012 %>% 
  select(HC04_EST_VC01,
         HC04_EST_VC02,
         HC04_EST_VC03,
         HC04_EST_VC04,
         HC04_EST_VC09,
         HC04_EST_VC11,
         HC04_EST_VC16,
         HC04_EST_VC17,
         HC04_EST_VC24,
         HC04_EST_VC25,
         HC04_EST_VC26,
         HC04_EST_VC27,
         HC04_EST_VC28,
         HC04_EST_VC32,
         HC04_EST_VC33,
         HC04_EST_VC34) %>%  
  rename(all = HC04_EST_VC01,
         w1519 = HC04_EST_VC02,
         w2034 = HC04_EST_VC03,
         w3550 = HC04_EST_VC04,
         black = HC04_EST_VC09,
         asian = HC04_EST_VC11,
         hispanic = HC04_EST_VC16,
         white = HC04_EST_VC17,
         nohs = HC04_EST_VC24,
         hs = HC04_EST_VC25,
         somecollege = HC04_EST_VC26,
         bach = HC04_EST_VC27,
         grad = HC04_EST_VC28,
         pbelow100 = HC04_EST_VC32,
         p100_199 = HC04_EST_VC33,
         p200plus = HC04_EST_VC34) %>% 
  mutate(Year = 2012) %>% 
  lapply(as.numeric) %>% 
  data.frame() %>%  
  gather(`all`, 
         `w1519`, 
         `w2034`, 
         `w3550`, 
         `black`, 
         `asian`, 
         `hispanic`, 
         `white`, 
         `nohs`,
         `hs`,
         `somecollege`,
         `bach`,
         `grad`,
         `pbelow100`,
         `p100_199`,
         `p200plus`,
         key = type, 
         value = Rate)

sf_2011 <- read_csv("G:/DC Policy Center/Fertility/Data/Tab/state_fertility/ACS_11_5YR_S1301_with_ann.csv")
sf_2011 = sf_2011[-1,]
sf_2011 <- sf_2011 %>% 
  select(HC04_EST_VC01,
         HC04_EST_VC02,
         HC04_EST_VC03,
         HC04_EST_VC04,
         HC04_EST_VC09,
         HC04_EST_VC11,
         HC04_EST_VC16,
         HC04_EST_VC17,
         HC04_EST_VC24,
         HC04_EST_VC25,
         HC04_EST_VC26,
         HC04_EST_VC27,
         HC04_EST_VC28,
         HC04_EST_VC32,
         HC04_EST_VC33,
         HC04_EST_VC34) %>%  
  rename(all = HC04_EST_VC01,
         w1519 = HC04_EST_VC02,
         w2034 = HC04_EST_VC03,
         w3550 = HC04_EST_VC04,
         black = HC04_EST_VC09,
         asian = HC04_EST_VC11,
         hispanic = HC04_EST_VC16,
         white = HC04_EST_VC17,
         nohs = HC04_EST_VC24,
         hs = HC04_EST_VC25,
         somecollege = HC04_EST_VC26,
         bach = HC04_EST_VC27,
         grad = HC04_EST_VC28,
         pbelow100 = HC04_EST_VC32,
         p100_199 = HC04_EST_VC33,
         p200plus = HC04_EST_VC34) %>% 
  mutate(Year = 2011) %>% 
  lapply(as.numeric) %>% 
  data.frame() %>%  
  gather(`all`, 
         `w1519`, 
         `w2034`, 
         `w3550`, 
         `black`, 
         `asian`, 
         `hispanic`, 
         `white`, 
         `nohs`,
         `hs`,
         `somecollege`,
         `bach`,
         `grad`,
         `pbelow100`,
         `p100_199`,
         `p200plus`,
         key = type, 
         value = Rate)

sf_2010 <- read_csv("G:/DC Policy Center/Fertility/Data/Tab/state_fertility/ACS_10_5YR_S1301_with_ann.csv")
sf_2010 = sf_2010[-1,]
sf_2010 <- sf_2010 %>% 
  select(HC04_EST_VC01,
         HC04_EST_VC02,
         HC04_EST_VC03,
         HC04_EST_VC04,
         HC04_EST_VC09,
         HC04_EST_VC11,
         HC04_EST_VC16,
         HC04_EST_VC17,
         HC04_EST_VC24,
         HC04_EST_VC25,
         HC04_EST_VC26,
         HC04_EST_VC27,
         HC04_EST_VC28,
         HC04_EST_VC32,
         HC04_EST_VC33,
         HC04_EST_VC34) %>%  
  rename(all = HC04_EST_VC01,
         w1519 = HC04_EST_VC02,
         w2034 = HC04_EST_VC03,
         w3550 = HC04_EST_VC04,
         black = HC04_EST_VC09,
         asian = HC04_EST_VC11,
         hispanic = HC04_EST_VC16,
         white = HC04_EST_VC17,
         nohs = HC04_EST_VC24,
         hs = HC04_EST_VC25,
         somecollege = HC04_EST_VC26,
         bach = HC04_EST_VC27,
         grad = HC04_EST_VC28,
         pbelow100 = HC04_EST_VC32,
         p100_199 = HC04_EST_VC33,
         p200plus = HC04_EST_VC34) %>% 
  mutate(Year = 2010) %>% 
  lapply(as.numeric) %>% 
  data.frame() %>%  
  gather(`all`, 
         `w1519`, 
         `w2034`, 
         `w3550`, 
         `black`, 
         `asian`, 
         `hispanic`, 
         `white`, 
         `nohs`,
         `hs`,
         `somecollege`,
         `bach`,
         `grad`,
         `pbelow100`,
         `p100_199`,
         `p200plus`,
         key = type, 
         value = Rate)

sf_2009 <- read_csv("G:/DC Policy Center/Fertility/Data/Tab/state_fertility/ACS_09_5YR_S1301_with_ann.csv")
sf_2009 = sf_2009[-1,]
sf_2009 <- sf_2009 %>% 
  select(HC04_EST_VC01,
         HC04_EST_VC02,
         HC04_EST_VC03,
         HC04_EST_VC04,
         HC04_EST_VC08,
         HC04_EST_VC10,
         HC04_EST_VC14,
         HC04_EST_VC15,
         HC04_EST_VC20,
         HC04_EST_VC21,
         HC04_EST_VC22,
         HC04_EST_VC23,
         HC04_EST_VC24,
         HC04_EST_VC27,
         HC04_EST_VC28,
         HC04_EST_VC29) %>%  
  rename(all = HC04_EST_VC01,
         w1519 = HC04_EST_VC02,
         w2034 = HC04_EST_VC03,
         w3550 = HC04_EST_VC04,
         black = HC04_EST_VC08,
         asian = HC04_EST_VC10,
         hispanic = HC04_EST_VC14,
         white = HC04_EST_VC15,
         nohs = HC04_EST_VC20,
         hs = HC04_EST_VC21,
         somecollege = HC04_EST_VC22,
         bach = HC04_EST_VC23,
         grad = HC04_EST_VC24,
         pbelow100 = HC04_EST_VC27,
         p100_199 = HC04_EST_VC28,
         p200plus = HC04_EST_VC29) %>% 
  mutate(Year = 2009) %>% 
  lapply(as.numeric) %>% 
  data.frame() %>%  
  gather(`all`, 
         `w1519`, 
         `w2034`, 
         `w3550`, 
         `black`, 
         `asian`, 
         `hispanic`, 
         `white`, 
         `nohs`,
         `hs`,
         `somecollege`,
         `bach`,
         `grad`,
         `pbelow100`,
         `p100_199`,
         `p200plus`,
         key = type, 
         value = Rate)

sf_2008 <- read_csv("G:/DC Policy Center/Fertility/Data/Tab/state_fertility/ACS_08_3YR_S1301_with_ann.csv")
sf_2008 = sf_2008[-1,]
sf_2008 <- sf_2008 %>% 
  select(HC04_EST_VC01,
         HC04_EST_VC02,
         HC04_EST_VC03,
         HC04_EST_VC04,
         HC04_EST_VC08,
         HC04_EST_VC10,
         HC04_EST_VC14,
         HC04_EST_VC15,
         HC04_EST_VC20,
         HC04_EST_VC21,
         HC04_EST_VC22,
         HC04_EST_VC23,
         HC04_EST_VC24,
         HC04_EST_VC27,
         HC04_EST_VC28,
         HC04_EST_VC29) %>%  
  rename(all = HC04_EST_VC01,
         w1519 = HC04_EST_VC02,
         w2034 = HC04_EST_VC03,
         w3550 = HC04_EST_VC04,
         black = HC04_EST_VC08,
         asian = HC04_EST_VC10,
         hispanic = HC04_EST_VC14,
         white = HC04_EST_VC15,
         nohs = HC04_EST_VC20,
         hs = HC04_EST_VC21,
         somecollege = HC04_EST_VC22,
         bach = HC04_EST_VC23,
         grad = HC04_EST_VC24,
         pbelow100 = HC04_EST_VC27,
         p100_199 = HC04_EST_VC28,
         p200plus = HC04_EST_VC29) %>% 
  mutate(Year = 2008) %>% 
  lapply(as.numeric) %>% 
  data.frame() %>%  
  gather(`all`, 
         `w1519`, 
         `w2034`, 
         `w3550`, 
         `black`, 
         `asian`, 
         `hispanic`, 
         `white`, 
         `nohs`,
         `hs`,
         `somecollege`,
         `bach`,
         `grad`,
         `pbelow100`,
         `p100_199`,
         `p200plus`,
         key = type, 
         value = Rate)

sf_2007 <- read_csv("G:/DC Policy Center/Fertility/Data/Tab/state_fertility/ACS_07_3YR_S1301_with_ann.csv")
sf_2007 = sf_2007[-1,]
sf_2007 <- sf_2007 %>% 
  select(HC04_EST_VC01,
         HC04_EST_VC02,
         HC04_EST_VC03,
         HC04_EST_VC04,
         HC04_EST_VC08,
         HC04_EST_VC10,
         HC04_EST_VC14,
         HC04_EST_VC15,
         HC04_EST_VC20,
         HC04_EST_VC21,
         HC04_EST_VC22,
         HC04_EST_VC23,
         HC04_EST_VC24,
         HC04_EST_VC27,
         HC04_EST_VC28,
         HC04_EST_VC29) %>%  
  rename(all = HC04_EST_VC01,
         w1519 = HC04_EST_VC02,
         w2034 = HC04_EST_VC03,
         w3550 = HC04_EST_VC04,
         black = HC04_EST_VC08,
         asian = HC04_EST_VC10,
         hispanic = HC04_EST_VC14,
         white = HC04_EST_VC15,
         nohs = HC04_EST_VC20,
         hs = HC04_EST_VC21,
         somecollege = HC04_EST_VC22,
         bach = HC04_EST_VC23,
         grad = HC04_EST_VC24,
         pbelow100 = HC04_EST_VC27,
         p100_199 = HC04_EST_VC28,
         p200plus = HC04_EST_VC29) %>% 
  mutate(Year = 2007) %>% 
  lapply(as.numeric) %>% 
  data.frame() %>%  
  gather(`all`, 
         `w1519`, 
         `w2034`, 
         `w3550`, 
         `black`, 
         `asian`, 
         `hispanic`, 
         `white`, 
         `nohs`,
         `hs`,
         `somecollege`,
         `bach`,
         `grad`,
         `pbelow100`,
         `p100_199`,
         `p200plus`,
         key = type, 
         value = Rate)

sf_2006 <- read_csv("G:/DC Policy Center/Fertility/Data/Tab/state_fertility/ACS_06_EST_S1301_with_ann.csv")
sf_2006 = sf_2006[-1,]
sf_2006 <- sf_2006 %>% 
  select(HC04_EST_VC01,
         HC04_EST_VC02,
         HC04_EST_VC03,
         HC04_EST_VC04,
         HC04_EST_VC08,
         HC04_EST_VC10,
         HC04_EST_VC14,
         HC04_EST_VC15,
         HC04_EST_VC20,
         HC04_EST_VC21,
         HC04_EST_VC22,
         HC04_EST_VC23,
         HC04_EST_VC24,
         HC04_EST_VC27,
         HC04_EST_VC28,
         HC04_EST_VC29) %>%  
  rename(all = HC04_EST_VC01,
         w1519 = HC04_EST_VC02,
         w2034 = HC04_EST_VC03,
         w3550 = HC04_EST_VC04,
         black = HC04_EST_VC08,
         asian = HC04_EST_VC10,
         hispanic = HC04_EST_VC14,
         white = HC04_EST_VC15,
         nohs = HC04_EST_VC20,
         hs = HC04_EST_VC21,
         somecollege = HC04_EST_VC22,
         bach = HC04_EST_VC23,
         grad = HC04_EST_VC24,
         pbelow100 = HC04_EST_VC27,
         p100_199 = HC04_EST_VC28,
         p200plus = HC04_EST_VC29) %>% 
  mutate(Year = 2006) %>% 
  lapply(as.numeric) %>% 
  data.frame() %>%  
  gather(`all`, 
         `w1519`, 
         `w2034`, 
         `w3550`, 
         `black`, 
         `asian`, 
         `hispanic`, 
         `white`, 
         `nohs`,
         `hs`,
         `somecollege`,
         `bach`,
         `grad`,
         `pbelow100`,
         `p100_199`,
         `p200plus`,
         key = type, 
         value = Rate)

sf_2005 <- read_csv("G:/DC Policy Center/Fertility/Data/Tab/state_fertility/ACS_05_EST_S1301_with_ann.csv")
sf_2005 = sf_2005[-1,]
sf_2005 <- sf_2005 %>% 
  select(HC04_EST_VC01,
         HC04_EST_VC02,
         HC04_EST_VC03,
         HC04_EST_VC04,
         HC04_EST_VC08,
         HC04_EST_VC10,
         HC04_EST_VC14,
         HC04_EST_VC15,
         HC04_EST_VC30,
         HC04_EST_VC31,
         HC04_EST_VC32,
         HC04_EST_VC33,
         HC04_EST_VC34,
         HC04_EST_VC22,
         HC04_EST_VC23,
         HC04_EST_VC24) %>%  
  rename(all = HC04_EST_VC01,
         w1519 = HC04_EST_VC02,
         w2034 = HC04_EST_VC03,
         w3550 = HC04_EST_VC04,
         black = HC04_EST_VC08,
         asian = HC04_EST_VC10,
         hispanic = HC04_EST_VC14,
         white = HC04_EST_VC15,
         nohs = HC04_EST_VC30,
         hs = HC04_EST_VC31,
         somecollege = HC04_EST_VC32,
         bach = HC04_EST_VC33,
         grad = HC04_EST_VC34,
         pbelow100 = HC04_EST_VC22,
         p100_199 = HC04_EST_VC23,
         p200plus = HC04_EST_VC24) %>% 
  mutate(Year = 2005) %>% 
  lapply(as.numeric) %>% 
  data.frame() %>%  
  gather(`all`, 
         `w1519`, 
         `w2034`, 
         `w3550`, 
         `black`, 
         `asian`, 
         `hispanic`, 
         `white`, 
         `nohs`,
         `hs`,
         `somecollege`,
         `bach`,
         `grad`,
         `pbelow100`,
         `p100_199`,
         `p200plus`,
         key = type, 
         value = Rate)
# State summary by key demographics
state_sum <- rbind(sf_2005, sf_2006, sf_2007, sf_2008, sf_2009, sf_2010, sf_2011, sf_2012, sf_2013, sf_2014, sf_2015) %>% 
  group_by(type) %>% 
  arrange(desc(type))


#-------------------------------------------------------------------------------------------------------------------------------------------------------------
# Line graphs for various demographics

# Age
# set color scheme and legend labels
agecol <- c("#E8272C", "#527394", "#8BCFC5", "#B16379")
agedemo <- c("Overall", "Women 15 to 19", "Women 20 to 34", "Women 35 to 50")

# Create line graph for birth rates from 2009 to 2015
age <- state_sum %>% 
  filter(type == "all" | type == "w1519" | type == "w2034" | type == "w3550") %>% 
  group_by(type) %>% 
  arrange(type) %>% 
  ggplot(aes(x = Year, y = Rate, color = type)) +
  geom_line(size = 1) +
  scale_colour_manual(labels = agedemo, values = agecol) +
  ylim(c(0,85)) +
  scale_x_continuous(breaks = round(seq(min(2005), max(2015), by = 1),1)) +
  labs(color = "Age Ranges",
       x = "Year", y = "Birth Rate per 1000",
       title = "Birth rates have recovered among women\n35yo to 50yo back to 2005 levels ",
       subtitle = "Birth rates by age group in Washington, D.C., 2005 - 2015",
       caption = "Source: American Community Survey, 2005 - 2015") + 
  theme_ipsum_rc()
age

# Race
# set color scheme and legend labels
racecol <- c("#E8272C", "#527394", "#8BCFC5", "#B16379", "#D16D3B")
racedemo <- c("Overall", "Asian", "African American", "Hispanic/Latino", "White")

# Create line graph for birth rates from 2009 to 2015
race <- state_sum %>% 
  filter(type == "all" | type == "asian" | type == "black" | type == "hispanic" | type == "white") %>% 
  group_by(type) %>% 
  arrange(type) %>% 
  ggplot(aes(x = Year, y = Rate, color = type)) +
  geom_line(size = 1) +
  scale_colour_manual(labels = racedemo, values = racecol) +
  ylim(c(0,115)) +
  scale_x_continuous(breaks = round(seq(min(2005), max(2015), by = 1),1)) +
  labs(color = "Race",
       x = "Year", y = "Birth Rate per 1000",
       title = "Birth rates of Hispanics/Latinos have dropped 52%",
       subtitle = "Birth rates by race in Washington, D.C., 2005 - 2015",
       caption = "Source: American Community Survey, 2005 - 2015") + 
  theme_ipsum_rc()
race

# Education
# set color scheme and legend labels
edcol <- c("#E8272C", "#527394", "#8BCFC5", "#B16379", "#D16D3B")
eddemo <- c("Overall", "No High School", "HS Diploma", "Bachelors", "Graduate")

# Create line graph for birth rates from 2009 to 2015
edu <- state_sum
edu$type <- gsub("all", "a", edu$type)
edu$type <- gsub("nohs", "b", edu$type)
edu$type <- gsub("hs", "c", edu$type)
edu$type <- gsub("bach", "d", edu$type)
edu$type <- gsub("grad", "e", edu$type)
education <- edu %>% 
  filter(type == "a" | type == "b" | type == "c" | type == "d" | type == "e") %>% 
  group_by(type) %>% 
  arrange(type) %>% 
  ggplot(aes(x = Year, y = Rate, color = type)) +
  geom_line(size = 1) +
  scale_colour_manual(labels = eddemo, values = edcol) +
  ylim(c(0,105)) +
  scale_x_continuous(breaks = round(seq(min(2005), max(2015), by = 1),1)) +
  labs(color = "Education",
       x = "Year", y = "Birth Rate per 1000",
       title = "Birth rates have decresed among all\neducational backgrounds",
       subtitle = "Birth rates by education in Washington, D.C., 2005 - 2015",
       caption = "Source: American Community Survey, 2005 - 2015") + 
  theme_ipsum_rc()
education

# Poverty
# set color scheme and legend labels
povcol <- c("#E8272C", "#527394", "#8BCFC5", "#B16379")
povdemo <- c("Overall", "< 100%", "100% to 199%", "> 200%")

# Create line graph for birth rates from 2009 to 2015
pov <- state_sum
pov$type <- gsub("all", "a", pov$type)
pov$type <- gsub("pbelow100", "b", pov$type)
pov$type <- gsub("p100_199", "c", pov$type)
pov$type <- gsub("p200plus", "d", pov$type)
poverty <- pov %>% 
  filter(type == "a" | type == "b" | type == "c" | type == "d") %>% 
  group_by(type) %>% 
  arrange(type) %>% 
  ggplot(aes(x = Year, y = Rate, color = type)) +
  geom_line(size = 1) +
  scale_colour_manual(labels = povdemo, values = povcol) +
  ylim(c(0,120)) +
  scale_x_continuous(breaks = round(seq(min(2005), max(2015), by = 1),1)) +
  labs(color = "Poverty Level Status",
       x = "Year", y = "Birth Rate per 1000",
       title = "Birth rates among women below\npoverty line have dropped 50%",
       subtitle = "Birth rates by poverty status in Washington, D.C., 2005 - 2015",
       caption = "Source: American Community Survey, 2005 - 2015") + 
  theme_ipsum_rc()
poverty





