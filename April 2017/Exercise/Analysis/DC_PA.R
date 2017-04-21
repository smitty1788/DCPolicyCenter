library("xlsx")
library(tidyr)
library(sqldf)
library(stringr)
library(hrbrthemes)
library(gcookbook)
library(tidyverse)


#Import Raw Data
Cities_Health <- read_csv("G:/DC Policy Center/Physcial Activity/Data/Tab/500_Cities__Local_Data_for_Better_Health.csv")

# Filter out data for cities with population > 300000 and tidy data for graph
city <- sqldf("select * from Cities_Health where GeographicLevel is 'City'") %>% 
  filter(DataValueTypeID == "AgeAdjPrv") %>%
  select(CityName,
         PopulationCount,
         Short_Question_Text,
         Data_Value) %>%
  filter(Short_Question_Text == "Physical Activity") %>%
  rename(Physical_Activity = Data_Value) %>%
  select(CityName,
         PopulationCount,
         Physical_Activity) %>%
  filter(PopulationCount >= 300000) %>%
  arrange(Physical_Activity)

# write to csv
write.csv(city, file = "G:/DC Policy Center/Physcial Activity/Data/Tab/Tidy/city_phys_activity.csv", row.names = FALSE)

#-------------------------------------------------------------------------------------------------------------------------------
# DC only data
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
write.xlsx(DC, file = "G:/DC Policy Center/Physcial Activity/Data/Tab/Tidy/DC_Health.xlsx", sheetName = "Health", row.names = FALSE)

#-----------------------------------------------------------------------------------------------------
# Import data for demographics and physical activity

ct_data <- read_csv("G:/DC Policy Center/Physcial Activity/Data/Tab/ct_data.csv") %>% 
  filter(N_Cluster > 0)


# Multivariate regression
regression <- lm(ct_data$PhysicalActivity ~ ct_data$P_BelowPovertyLevel + ct_data$P_SNAP_Household_Recieveing + ct_data$P_Black)
#look at result and statistics
summary(regression)
#extract coefficients only
coef(regression)


# Dataframe with prediticed percents of physical activity based on regression forumla
model <- ct_data %>% 
  mutate(predicted = 0.2117190 * P_BelowPovertyLevel + 0.0510858 * P_SNAP_Household_Recieveing + 0.1516290 * P_Black + 7.9110785) %>% 
  transform(N_Cluster = as.character(N_Cluster))


# reorganizing data to create scatterplot of all three regression variables 
p <- ct_data %>% 
  gather(P_BelowPovertyLevel, P_SNAP_Household_Recieveing, P_Black, key = type, value = percent)


# set colors and labels for legend
col <- c("#527394", "#8BCFC5", "#B16379")
demo <- c("% Below Poverty Level", "% African American", "% SNAP Recieving Household")


# scatterplot of physical activity vs regression variables
p %>% 
  ggplot(aes(x = percent, y = PhysicalActivity, color = type)) +
  scale_colour_manual(labels = demo, values = col) +
  geom_point() +
  ylim(c(0,45)) +
  labs(color = "Demographics",
       x = "% of demographic", y = "% of adults who do not exercise",
       title = "Influence of demographics on exercise",
       subtitle = "Percentage of adults who don't exercise in Washington, D.C.",
       caption = "Source: Centers for Disease Control and Prevention, 2014\n American Community Survey, 2015") + 
  theme_ipsum_rc()


# scatterplot of predicted vs observed from multivariate model 
model %>% 
  ggplot(aes(predicted, PhysicalActivity)) +
  geom_point() +
  stat_smooth(method = 'lm', formula = y ~ x, color = "#6D7D8C") +
  ylim(c(0,45)) +
  xlim(c(0,45)) +
  labs(x = "Predicted %", y = "Observed %",
       title = "Multivariate Regression",
       subtitle = "Percentage of adults who don't exercise",
       caption = "y = 0.2117190a + 0.0510858b + 0.1516290c + 7.9110785\n R2 = .92") + 
  theme_ipsum_rc()


