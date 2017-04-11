library(rgdal)
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("biclust")
library("cluster")
library("igraph")
library("fpc")
library("xlsx")
library(tidyverse)

#----------------------------------------------------------------------------------------------------------------------------------------
#
# Import Tab Data
all <- read_csv("G:/DC Policy Center/Vision Zero Requests/Data/Tab/Vision_Zero_Safety_Transportation.csv")

# The input file geodatabase
fgdb = "G:/DC Policy Center/Vision Zero Requests/Data/Spatial/VZero.gdb"

# List all feature classes in a file geodatabase
subset(ogrDrivers(), grepl("GDB", name))
fc_list = ogrListLayers(fgdb)
print(fc_list)

# Read the feature class
street_shp <- readOGR(dsn=fgdb,layer="Streets")


#
# Subset data into pedestrian, car, and bike
pedestrian <- all %>%
  filter(USERTYPE == "Pedestrian")

car <- all %>%
  filter(USERTYPE == "Car Driver")
  
bike <- all %>%
  filter(USERTYPE == "Biker")

write.csv(pedestrian, file = "G:/DC Policy Center/Vision Zero Requests/Data/Tab/Tidy/pedestrian.csv", row.names = FALSE)
write.csv(car, file = "G:/DC Policy Center/Vision Zero Requests/Data/Tab/Tidy/car.csv", row.names = FALSE)
write.csv(bike, file = "G:/DC Policy Center/Vision Zero Requests/Data/Tab/Tidy/bike.csv", row.names = FALSE)




#
# Calculate counts per Street segment and join to shapefile
all_count <- all %>%
  count(STREETSEGID) %>%
  arrange(desc(n)) %>%
  rename(Total = n,
         STREETSEGID = STREETSEGID)


ped_count <- pedestrian %>%
  count(STREETSEGID) %>%
  arrange(desc(n)) %>%
  rename(Ped = n,
         STREETSEGID = STREETSEGID)

car_count <- car %>%
  count(STREETSEGID) %>%
  arrange(desc(n)) %>%
  rename(Car = n,
         STREETSEGID = STREETSEGID)

bike_count <- bike %>%
  count(STREETSEGID) %>%
  arrange(desc(n)) %>%
  rename(Bike = n,
         STREETSEGID = STREETSEGID)

# Merge all counts to one dataframe
street_summary <- merge(x = all_count, y = ped_count, by = 'STREETSEGID', all.x = TRUE, all.y = TRUE) %>%
  merge(y = car_count, by = 'STREETSEGID', all.x = TRUE, all.y = TRUE) %>%
  merge(y = bike_count, by = 'STREETSEGID', all.x = TRUE, all.y = TRUE)

# Merge dataframe to shapefile
street_shp <- merge(x = street_shp, y = street_summary, by.x = 'STREETSEGI', by.y = 'STREETSEGID', all.x = TRUE)

# Write to new shapefile
writeOGR(street_shp, "G:/DC Policy Center/Vision Zero Requests/Data/Spatial", "street", driver = "ESRI Shapefile")



#
# Calculate counts by request type
all_request <- all %>%
  count(REQUESTTYPE) %>%
  arrange(desc(n)) %>%
  rename(Total = n,
         REQUESTTYPE = REQUESTTYPE)


ped_request <- pedestrian %>%
  count(REQUESTTYPE) %>%
  arrange(desc(n)) %>%
  rename(Ped = n,
         REQUESTTYPE = REQUESTTYPE)

car_request <- car %>%
  count(REQUESTTYPE) %>%
  arrange(desc(n)) %>%
  rename(Car = n,
         REQUESTTYPE = REQUESTTYPE)

bike_request <- bike %>%
  count(REQUESTTYPE) %>%
  arrange(desc(n)) %>%
  rename(Bike = n,
         REQUESTTYPE = REQUESTTYPE)

# Merge all counts to one dataframe
request_summary <- merge(x = all_request, y = ped_request, by = 'REQUESTTYPE', all.x = TRUE, all.y = TRUE) %>%
  merge(y = car_request, by = 'REQUESTTYPE', all.x = TRUE, all.y = TRUE) %>%
  merge(y = bike_request, by = 'REQUESTTYPE', all.x = TRUE, all.y = TRUE) %>%
  arrange(desc(Total))

# write to csv
write.csv(request_summary, file = "G:/DC Policy Center/Vision Zero Requests/Data/Tab/Tidy/request_summary.csv", row.names = FALSE)



#-----------------------------------------------------------------------------------------------------------
# Word cloud of request comments
text <- readLines("G:/DC Policy Center/Vision Zero Requests/Data/Tab/Comments/comments.txt")

ped_comments <- pedestrian %>%
  filter(REQUESTTYPE == "Other Walking Issue") %>%
  select(COMMENTS)

car_comments <- car %>%
  filter(REQUESTTYPE == "Other Driving Issue") %>%
  select(COMMENTS)

bike_comments <- bike %>%
  filter(REQUESTTYPE == "Other Biking Issue") %>%
  select(COMMENTS)



# Create Corpus 
Comments <- Corpus(VectorSource(text))
ped_comments <- Corpus(VectorSource(ped_comments))
car_comments <- Corpus(VectorSource(car_comments))
bike_comments <- Corpus(VectorSource(bike_comments))


# Clean text data and remove words
clean <- Comments %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removeNumbers) %>%
  tm_map(removeWords, stopwords("english")) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace) %>%
  tm_map(stemDocument)

ped_clean <- ped_comments %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removeNumbers) %>%
  tm_map(removeWords, stopwords("english")) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace) %>%
  
  tm_map(stemDocument)

car_clean <- car_comments %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removeNumbers) %>%
  tm_map(removeWords, stopwords("english")) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace) %>%
  tm_map(stemDocument)

bike_clean <- bike_comments %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removeNumbers) %>%
  tm_map(removeWords, stopwords("english")) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace) %>%
  tm_map(stemDocument)


# Convert corpus to dataframe  
dtm <- TermDocumentMatrix(clean)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 20)

ped_dtm <- TermDocumentMatrix(ped_clean)
ped_m <- as.matrix(ped_dtm)
ped_v <- sort(rowSums(ped_m),decreasing=TRUE)
ped_d <- data.frame(word = names(ped_v),freq = ped_v)
head(ped_d, 20)

car_dtm <- TermDocumentMatrix(car_clean)
car_m <- as.matrix(car_dtm)
car_v <- sort(rowSums(car_m),decreasing=TRUE)
car_d <- data.frame(word = names(car_v),freq = car_v)
head(car_d, 20)

bike_dtm <- TermDocumentMatrix(bike_clean)
bike_m <- as.matrix(bike_dtm)
bike_v <- sort(rowSums(bike_m),decreasing=TRUE)
bike_d <- data.frame(word = names(bike_v),freq = bike_v)
head(bike_d, 20)


# Create Wordcloud
set.seed(142)
wordcloud(words = d$word, freq = d$freq, min.freq = 200,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

set.seed(142)
wordcloud(words = ped_d$word, freq = ped_d$freq, min.freq = 40,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

set.seed(142)
wordcloud(words = car_d$word, freq = car_d$freq, min.freq = 40,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

set.seed(142)
wordcloud(words = bike_d$word, freq = bike_d$freq, min.freq = 40,
          max.words=200, random.order=TRUE, rot.per=0.5, 
          colors=brewer.pal(8, "Dark2"))


#------------------------------------------------------------------------------------------------------------------------------
# Summarize and compare Top words among peds, cars, and bikes

# Rename frequency to applicable type
word <- rename(d,
               All = freq)

word_ped <- rename(ped_d,
                   Ped = freq)

word_car <- rename(car_d,
                   Car = freq)

word_bike <- rename(bike_d,
                    Bike = freq)


# table join all dataframes
word_compare <- merge(x = word, y = word_ped, by = 'word', all.x = TRUE, all.y = TRUE) %>%
  merge(y = word_car, by = 'word', all.x = TRUE, all.y = TRUE) %>%
  merge(y = word_bike, by = 'word', all.x = TRUE, all.y = TRUE) %>%
  mutate(All = Ped + Bike + Car) %>%
  arrange(desc(All))


write.csv(word_compare, file = "G:/DC Policy Center/Vision Zero Requests/Data/Tab/Tidy/word_comaprision.csv", row.names = FALSE, na="")

#------------------------------------------------------------------------------------------------------------------------------------------------

# Deeper dive into what streets are most often recorded with certain words
dupont <- all %>%
  filter(str_detect(COMMENTS, "lane")) %>%
  filter(REQUESTTYPE == "Other Biking Issue")

test <- dupont %>%
  filter(STREETSEGID == 2730)


dupont %>%
  count(STREETSEGID, n()) %>%
  arrange(desc(n))


filter(str_detect(Treatment, "non"))

#---------------------------------------------------------------------------------------------------------------------------------------------
# Demographic analysis

Transport <- read_csv("G:/DC Policy Center/Vision Zero Requests/Data/Tab/Means_Transport/ACS_15_5YR_B08301_with_ann.csv")

Transport = Transport[-1,]

Transport <- Transport %>%
  
  transform(GEOID = as.character(GEO.id2),
    Total_Trans = as.numeric(HD01_VD01),
    Car = as.numeric(HD01_VD02),
    Public = as.numeric(HD01_VD10),
    Bus = as.numeric(HD01_VD11),
    Metro = as.numeric(HD01_VD13),
    taxi = as.numeric(HD01_VD16),
    motorcycle = as.numeric(HD01_VD17),
    Bike = as.numeric(HD01_VD18),
    Walk = as.numeric(HD01_VD19)) %>%
  
  mutate(P_Car = (Car / Total_Trans) * 100,
         P_Bike = (Bike / Total_Trans) * 100,
         P_Walk = (Walk / Total_Trans) * 100) %>%
  
  select(GEOID,
         Total_Trans,
         Car,
         P_Car,
         Bike,
         P_Bike,
         Walk,
         P_Walk)

write.xlsx(Transport, file = "G:/DC Policy Center/Vision Zero Requests/Data/Tab/Tidy/transport.xlsx",
           sheetName = "transport",
           row.names = FALSE)

ct_stats <- read.csv("G:/DC Policy Center/Vision Zero Requests/Data/Tab/CT_Demo.csv")

n_stats <- ct_stats %>%
  group_by(CT_VZ_Count_N_Name, CT_VZ_Count_N_Cluster) %>%
  summarize(Total = sum(CT_VZ_Count_Total), 
            Bike = sum(CT_VZ_Count_Bike), 
            Car = sum(CT_VZ_Count_Car), 
            Ped = sum(CT_VZ_Count_pedestrian)) %>%
  arrange(desc(Total))

write.csv(n_stats, file = "G:/DC Policy Center/Vision Zero Requests/Data/Tab/Tidy/n_stats.csv", row.names = FALSE, na="")

#------------------------------------------------------------------------------------------------------------------------------------
# Comparision of Speeding requests and speeding tickets

# Import Moving violation data
mvjan16 <- read_csv("G:/DC Policy Center/Moving Violations/Data/Tab/2016/Moving_Violations_in_January_2016.csv")
mvfeb16 <- read_csv("G:/DC Policy Center/Moving Violations/Data/Tab/2016/Moving_Violations_in_February_2016.csv")
mvmar16 <- read_csv("G:/DC Policy Center/Moving Violations/Data/Tab/2016/Moving_Violations_in_March_2016.csv")
mvapr16 <- read_csv("G:/DC Policy Center/Moving Violations/Data/Tab/2016/Moving_Violations_in_April_2016.csv")
mvmay16 <- read_csv("G:/DC Policy Center/Moving Violations/Data/Tab/2016/Moving_Violations_in_May_2016.csv")
mvjun16 <- read_csv("G:/DC Policy Center/Moving Violations/Data/Tab/2016/Moving_Violations_in_June_2016.csv")
mvjul16 <- read_csv("G:/DC Policy Center/Moving Violations/Data/Tab/2016/Moving_Violations_in_July_2016.csv")
mvaug16 <- read_csv("G:/DC Policy Center/Moving Violations/Data/Tab/2016/Moving_Violations_in_August_2016.csv")
mvsep16 <- read_csv("G:/DC Policy Center/Moving Violations/Data/Tab/2016/Moving_Violations_in_September_2016.csv")
mvoct16 <- read_csv("G:/DC Policy Center/Moving Violations/Data/Tab/2016/Moving_Violations_in_October_2016.csv")
mvnov16 <- read_csv("G:/DC Policy Center/Moving Violations/Data/Tab/2016/Moving_Violations_in_November_2016.csv")
mvdec16 <- read_csv("G:/DC Policy Center/Moving Violations/Data/Tab/2016/Moving_Violations_in_December_2016.csv")

# Combine all data into one datafram
mv2016 <- rbind(mvjan16, mvfeb16, mvmar16, mvapr16, mvmay16, mvjun16, mvjul16, mvaug16, mvsep16, mvoct16, mvnov16, mvdec16) 

# Filter violations by those recieving speeding tickets
speed_ticket <- mv2016 %>%
  filter(str_detect(VIOLATIONDESC, "SPEED LIMIT"))

# Filter all requests by type equal to speed
speed_request <- all %>%
  filter(REQUESTTYPE == "Speeding")

# write both data frames to csv
write.csv(speed_ticket, file = "G:/DC Policy Center/Vision Zero Requests/Data/Tab/Tidy/speed_ticket.csv")
write.csv(speed_request, file = "G:/DC Policy Center/Vision Zero Requests/Data/Tab/Tidy/speed_request.csv")


# Count which streets have most requests
speed_request_roads <- speed_request %>%
  group_by(STREETSEGID) %>%
  count() %>%
  rename(Requests = n)

# Count which streets have most tickets
speed_ticket_roads <- speed_ticket %>%
  group_by(STREETSEGID) %>%
  count() %>%
  rename(Tickets = n)

# summary to find any overlap 

speed_summary <- merge(x = speed_ticket_roads, y = speed_request_roads, by = 'STREETSEGID', all.x = TRUE, all.y = TRUE) %>%
  arrange(desc(Requests))

write.csv(speed_summary, file = "G:/DC Policy Center/Vision Zero Requests/Data/Tab/Tidy/speed_summary.csv")


