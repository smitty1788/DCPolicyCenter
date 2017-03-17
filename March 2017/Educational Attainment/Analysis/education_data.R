library(tidyverse)
library("xlsx")


# State Level Field of Degree, selecting only top 6 from 2015
# Import all datasets
FOD09 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Field of Degree/ACS_09_1YR_B15012_with_ann.csv")
FOD10 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Field of Degree/ACS_10_1YR_B15012_with_ann.csv")
FOD11 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Field of Degree/ACS_11_1YR_B15012_with_ann.csv")
FOD12 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Field of Degree/ACS_12_1YR_B15012_with_ann.csv")
FOD13 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Field of Degree/ACS_13_1YR_B15012_with_ann.csv")
FOD14 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Field of Degree/ACS_14_1YR_B15012_with_ann.csv")
FOD15 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Field of Degree/ACS_15_1YR_B15012_with_ann.csv")


# Remove annotations row
FOD09 <- FOD09[-1,]
FOD10 <- FOD10[-1,]
FOD11 <- FOD11[-1,]
FOD12 <- FOD12[-1,]
FOD13 <- FOD13[-1,]
FOD14 <- FOD14[-1,]
FOD15 <- FOD15[-1,]


# Transform relevant fields to numeric
FOD09 <- transform(FOD09,
                   HD01_VD07 = as.numeric(HD01_VD07),
                   HD01_VD11 = as.numeric(HD01_VD11),
                   HD01_VD15 = as.numeric(HD01_VD15),
                   HD01_VD14 = as.numeric(HD01_VD14),
                   HD01_VD17 = as.numeric(HD01_VD17),
                   HD01_VD04 = as.numeric(HD01_VD04))
FOD10 <- transform(FOD10,
                   HD01_VD07 = as.numeric(HD01_VD07),
                   HD01_VD11 = as.numeric(HD01_VD11),
                   HD01_VD15 = as.numeric(HD01_VD15),
                   HD01_VD14 = as.numeric(HD01_VD14),
                   HD01_VD17 = as.numeric(HD01_VD17),
                   HD01_VD04 = as.numeric(HD01_VD04))
FOD11 <- transform(FOD11,
                   HD01_VD07 = as.numeric(HD01_VD07),
                   HD01_VD11 = as.numeric(HD01_VD11),
                   HD01_VD15 = as.numeric(HD01_VD15),
                   HD01_VD14 = as.numeric(HD01_VD14),
                   HD01_VD17 = as.numeric(HD01_VD17),
                   HD01_VD04 = as.numeric(HD01_VD04))
FOD12 <- transform(FOD12,
                   HD01_VD07 = as.numeric(HD01_VD07),
                   HD01_VD11 = as.numeric(HD01_VD11),
                   HD01_VD15 = as.numeric(HD01_VD15),
                   HD01_VD14 = as.numeric(HD01_VD14),
                   HD01_VD17 = as.numeric(HD01_VD17),
                   HD01_VD04 = as.numeric(HD01_VD04))
FOD13 <- transform(FOD13,
                   HD01_VD07 = as.numeric(HD01_VD07),
                   HD01_VD11 = as.numeric(HD01_VD11),
                   HD01_VD15 = as.numeric(HD01_VD15),
                   HD01_VD14 = as.numeric(HD01_VD14),
                   HD01_VD17 = as.numeric(HD01_VD17),
                   HD01_VD04 = as.numeric(HD01_VD04))
FOD14 <- transform(FOD14,
                   HD01_VD07 = as.numeric(HD01_VD07),
                   HD01_VD11 = as.numeric(HD01_VD11),
                   HD01_VD15 = as.numeric(HD01_VD15),
                   HD01_VD14 = as.numeric(HD01_VD14),
                   HD01_VD17 = as.numeric(HD01_VD17),
                   HD01_VD04 = as.numeric(HD01_VD04))
FOD15 <- transform(FOD15,
                   HD01_VD07 = as.numeric(HD01_VD07),
                   HD01_VD11 = as.numeric(HD01_VD11),
                   HD01_VD15 = as.numeric(HD01_VD15),
                   HD01_VD14 = as.numeric(HD01_VD14),
                   HD01_VD17 = as.numeric(HD01_VD17),
                   HD01_VD04 = as.numeric(HD01_VD04))


# Select relavant fields
FOD09 <- select(FOD09, HD01_VD07, HD01_VD11, HD01_VD15, HD01_VD14, HD01_VD17, HD01_VD04)
FOD10 <- select(FOD10, HD01_VD07, HD01_VD11, HD01_VD15, HD01_VD14, HD01_VD17, HD01_VD04)
FOD11 <- select(FOD11, HD01_VD07, HD01_VD11, HD01_VD15, HD01_VD14, HD01_VD17, HD01_VD04)
FOD12 <- select(FOD12, HD01_VD07, HD01_VD11, HD01_VD15, HD01_VD14, HD01_VD17, HD01_VD04)
FOD13 <- select(FOD13, HD01_VD07, HD01_VD11, HD01_VD15, HD01_VD14, HD01_VD17, HD01_VD04)
FOD14 <- select(FOD14, HD01_VD07, HD01_VD11, HD01_VD15, HD01_VD14, HD01_VD17, HD01_VD04)
FOD15 <- select(FOD15, HD01_VD07, HD01_VD11, HD01_VD15, HD01_VD14, HD01_VD17, HD01_VD04)



# Rename to actual field of degree
FOD09 <- rename(FOD09, 
                Social_Science = HD01_VD07,
                Business = HD01_VD11,
                Lib_Arts_History = HD01_VD15,
                Lit_Languages = HD01_VD14,
                Communications = HD01_VD17,
                Bio_ENSP = HD01_VD04)
FOD10 <- rename(FOD10, 
                Social_Science = HD01_VD07,
                Business = HD01_VD11,
                Lib_Arts_History = HD01_VD15,
                Lit_Languages = HD01_VD14,
                Communications = HD01_VD17,
                Bio_ENSP = HD01_VD04)
FOD11 <- rename(FOD11, 
                Social_Science = HD01_VD07,
                Business = HD01_VD11,
                Lib_Arts_History = HD01_VD15,
                Lit_Languages = HD01_VD14,
                Communications = HD01_VD17,
                Bio_ENSP = HD01_VD04)
FOD12 <- rename(FOD12, 
                Social_Science = HD01_VD07,
                Business = HD01_VD11,
                Lib_Arts_History = HD01_VD15,
                Lit_Languages = HD01_VD14,
                Communications = HD01_VD17,
                Bio_ENSP = HD01_VD04)
FOD13 <- rename(FOD13, 
                Social_Science = HD01_VD07,
                Business = HD01_VD11,
                Lib_Arts_History = HD01_VD15,
                Lit_Languages = HD01_VD14,
                Communications = HD01_VD17,
                Bio_ENSP = HD01_VD04)
FOD14 <- rename(FOD14, 
                Social_Science = HD01_VD07,
                Business = HD01_VD11,
                Lib_Arts_History = HD01_VD15,
                Lit_Languages = HD01_VD14,
                Communications = HD01_VD17,
                Bio_ENSP = HD01_VD04)
FOD15 <- rename(FOD15, 
                Social_Science = HD01_VD07,
                Business = HD01_VD11,
                Lib_Arts_History = HD01_VD15,
                Lit_Languages = HD01_VD14,
                Communications = HD01_VD17,
                Bio_ENSP = HD01_VD04)


# Add year field to datasets
FOD09 <- mutate(FOD09,date = 2009)
FOD10 <- mutate(FOD10,date = 2010)
FOD11 <- mutate(FOD11,date = 2011)
FOD12 <- mutate(FOD12,date = 2012)
FOD13 <- mutate(FOD13,date = 2013)
FOD14 <- mutate(FOD14,date = 2014)
FOD15 <- mutate(FOD15,date = 2015)


# Combine all datasets
FOD <- rbind(FOD09, FOD10, FOD11, FOD12, FOD13, FOD14, FOD15)


# Write to csv
write.csv(FOD, file = "G:/DC Policy Center/Educational Attainment/Data/Tab/Tidy/State_FOD.csv", row.names = FALSE)



#State Level Educational Attainment
# Import Datasets

Bach09 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment/ACS_09_1YR_S1501_with_ann.csv")
Bach10 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment/ACS_10_1YR_S1501_with_ann.csv")
Bach11 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment/ACS_11_1YR_S1501_with_ann.csv")
Bach12 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment/ACS_12_1YR_S1501_with_ann.csv")
Bach13 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment/ACS_13_1YR_S1501_with_ann.csv")
Bach14 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment/ACS_14_1YR_S1501_with_ann.csv")
Bach15 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment/ACS_15_1YR_S1501_with_ann.csv")

bach_white_09 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_White/ACS_09_1YR_B15002A_with_ann.csv")
bach_white_10 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_White/ACS_10_1YR_B15002A_with_ann.csv")
bach_white_11 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_White/ACS_11_1YR_B15002A_with_ann.csv")
bach_white_12 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_White/ACS_12_1YR_B15002A_with_ann.csv")
bach_white_13 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_White/ACS_13_1YR_B15002A_with_ann.csv")
bach_white_14 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_White/ACS_14_1YR_B15002A_with_ann.csv")
bach_white_15 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_White/ACS_15_1YR_B15002A_with_ann.csv")

bach_black_09 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Black/ACS_09_1YR_B15002B_with_ann.csv")
bach_black_10 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Black/ACS_10_1YR_B15002B_with_ann.csv")
bach_black_11 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Black/ACS_11_1YR_B15002B_with_ann.csv")
bach_black_12 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Black/ACS_12_1YR_B15002B_with_ann.csv")
bach_black_13 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Black/ACS_13_1YR_B15002B_with_ann.csv")
bach_black_14 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Black/ACS_14_1YR_B15002B_with_ann.csv")
bach_black_15 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Black/ACS_15_1YR_B15002B_with_ann.csv")

bach_asian_09 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Asian/ACS_09_1YR_B15002D_with_ann.csv")
bach_asian_10 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Asian/ACS_10_1YR_B15002D_with_ann.csv")
bach_asian_11 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Asian/ACS_11_1YR_B15002D_with_ann.csv")
bach_asian_12 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Asian/ACS_12_1YR_B15002D_with_ann.csv")
bach_asian_13 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Asian/ACS_13_1YR_B15002D_with_ann.csv")
bach_asian_14 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Asian/ACS_14_1YR_B15002D_with_ann.csv")
bach_asian_15 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Asian/ACS_15_1YR_B15002D_with_ann.csv")

bach_hisp_09 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Hisp/ACS_09_1YR_B15002I_with_ann.csv")
bach_hisp_10 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Hisp/ACS_10_1YR_B15002I_with_ann.csv")
bach_hisp_11 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Hisp/ACS_11_1YR_B15002I_with_ann.csv")
bach_hisp_12 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Hisp/ACS_12_1YR_B15002I_with_ann.csv")
bach_hisp_13 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Hisp/ACS_13_1YR_B15002I_with_ann.csv")
bach_hisp_14 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Hisp/ACS_14_1YR_B15002I_with_ann.csv")
bach_hisp_15 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/State/Educational_Attainment_Hisp/ACS_15_1YR_B15002I_with_ann.csv")


# Remove annotaions row

Bach09 <- Bach09[-1,]
Bach10 <- Bach10[-1,]
Bach11 <- Bach11[-1,]
Bach12 <- Bach12[-1,]
Bach13 <- Bach13[-1,]
Bach14 <- Bach14[-1,]
Bach15 <- Bach15[-1,]

bach_white_09 <- bach_white_09[-1,]
bach_white_10 <- bach_white_10[-1,]
bach_white_11 <- bach_white_11[-1,]
bach_white_12 <- bach_white_12[-1,]
bach_white_13 <- bach_white_13[-1,]
bach_white_14 <- bach_white_14[-1,]
bach_white_15 <- bach_white_15[-1,]

bach_black_09 <- bach_black_09[-1,]
bach_black_10 <- bach_black_10[-1,]
bach_black_11 <- bach_black_11[-1,]
bach_black_12 <- bach_black_12[-1,]
bach_black_13 <- bach_black_13[-1,]
bach_black_14 <- bach_black_14[-1,]
bach_black_15 <- bach_black_15[-1,]

bach_asian_09 <- bach_asian_09[-1,]
bach_asian_10 <- bach_asian_10[-1,]
bach_asian_11 <- bach_asian_11[-1,]
bach_asian_12 <- bach_asian_12[-1,]
bach_asian_13 <- bach_asian_13[-1,]
bach_asian_14 <- bach_asian_14[-1,]
bach_asian_15 <- bach_asian_15[-1,]

bach_hisp_09 <- bach_hisp_09[-1,]
bach_hisp_10 <- bach_hisp_10[-1,]
bach_hisp_11 <- bach_hisp_11[-1,]
bach_hisp_12 <- bach_hisp_12[-1,]
bach_hisp_13 <- bach_hisp_13[-1,]
bach_hisp_14 <- bach_hisp_14[-1,]
bach_hisp_15 <- bach_hisp_15[-1,]

# Transform relavent fields to numeric

Bach09 <- transform(Bach09,
                    HC01_EST_VC06 = as.numeric(HC01_EST_VC06),
                    HC01_EST_VC12 = as.numeric(HC01_EST_VC12),
                    HC01_EST_VC13 = as.numeric(HC01_EST_VC13))
Bach10 <- transform(Bach10,
                    HC01_EST_VC07 = as.numeric(HC01_EST_VC07),
                    HC01_EST_VC13 = as.numeric(HC01_EST_VC13),
                    HC01_EST_VC14 = as.numeric(HC01_EST_VC14))
Bach11 <- transform(Bach11,
                    HC01_EST_VC07 = as.numeric(HC01_EST_VC07),
                    HC01_EST_VC13 = as.numeric(HC01_EST_VC13),
                    HC01_EST_VC14 = as.numeric(HC01_EST_VC14))
Bach12 <- transform(Bach12,
                    HC01_EST_VC07 = as.numeric(HC01_EST_VC07),
                    HC01_EST_VC13 = as.numeric(HC01_EST_VC13),
                    HC01_EST_VC14 = as.numeric(HC01_EST_VC14))
Bach13 <- transform(Bach13,
                    HC01_EST_VC07 = as.numeric(HC01_EST_VC07),
                    HC01_EST_VC13 = as.numeric(HC01_EST_VC13),
                    HC01_EST_VC14 = as.numeric(HC01_EST_VC14))
Bach14 <- transform(Bach14,
                    HC01_EST_VC07 = as.numeric(HC01_EST_VC07),
                    HC01_EST_VC13 = as.numeric(HC01_EST_VC13),
                    HC01_EST_VC14 = as.numeric(HC01_EST_VC14))
Bach15 <- transform(Bach15,
                    HC01_EST_VC08 = as.numeric(HC01_EST_VC08),
                    HC01_EST_VC14 = as.numeric(HC01_EST_VC14),
                    HC01_EST_VC15 = as.numeric(HC01_EST_VC15))

bach_white_09 <- transform(bach_white_09,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
                           
bach_white_10 <- transform(bach_white_10,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_white_11 <- transform(bach_white_11,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_white_12 <- transform(bach_white_12,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_white_13 <- transform(bach_white_13,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_white_14 <- transform(bach_white_14,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_white_15 <- transform(bach_white_15,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))


bach_black_09 <- transform(bach_black_09,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))

bach_black_10 <- transform(bach_black_10,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_black_11 <- transform(bach_black_11,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_black_12 <- transform(bach_black_12,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_black_13 <- transform(bach_black_13,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_black_14 <- transform(bach_black_14,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_black_15 <- transform(bach_black_15,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))

bach_asian_09 <- transform(bach_asian_09,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))

bach_asian_10 <- transform(bach_asian_10,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_asian_11 <- transform(bach_asian_11,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_asian_12 <- transform(bach_asian_12,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_asian_13 <- transform(bach_asian_13,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_asian_14 <- transform(bach_asian_14,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))
bach_asian_15 <- transform(bach_asian_15,
                           Total = as.numeric(HD01_VD01),
                           Bach_M = as.numeric(HD01_VD09),
                           Grad_M = as.numeric(HD01_VD10),
                           Bach_F = as.numeric(HD01_VD18),
                           Grad_F = as.numeric(HD01_VD19))


bach_hisp_09 <- transform(bach_hisp_09,
                          Total = as.numeric(HD01_VD01),
                          Bach_M = as.numeric(HD01_VD09),
                          Grad_M = as.numeric(HD01_VD10),
                          Bach_F = as.numeric(HD01_VD18),
                          Grad_F = as.numeric(HD01_VD19))

bach_hisp_10 <- transform(bach_hisp_10,
                          Total = as.numeric(HD01_VD01),
                          Bach_M = as.numeric(HD01_VD09),
                          Grad_M = as.numeric(HD01_VD10),
                          Bach_F = as.numeric(HD01_VD18),
                          Grad_F = as.numeric(HD01_VD19))
bach_hisp_11 <- transform(bach_hisp_11,
                          Total = as.numeric(HD01_VD01),
                          Bach_M = as.numeric(HD01_VD09),
                          Grad_M = as.numeric(HD01_VD10),
                          Bach_F = as.numeric(HD01_VD18),
                          Grad_F = as.numeric(HD01_VD19))
bach_hisp_12 <- transform(bach_hisp_12,
                          Total = as.numeric(HD01_VD01),
                          Bach_M = as.numeric(HD01_VD09),
                          Grad_M = as.numeric(HD01_VD10),
                          Bach_F = as.numeric(HD01_VD18),
                          Grad_F = as.numeric(HD01_VD19))
bach_hisp_13 <- transform(bach_hisp_13,
                          Total = as.numeric(HD01_VD01),
                          Bach_M = as.numeric(HD01_VD09),
                          Grad_M = as.numeric(HD01_VD10),
                          Bach_F = as.numeric(HD01_VD18),
                          Grad_F = as.numeric(HD01_VD19))
bach_hisp_14 <- transform(bach_hisp_14,
                          Total = as.numeric(HD01_VD01),
                          Bach_M = as.numeric(HD01_VD09),
                          Grad_M = as.numeric(HD01_VD10),
                          Bach_F = as.numeric(HD01_VD18),
                          Grad_F = as.numeric(HD01_VD19))
bach_hisp_15 <- transform(bach_hisp_15,
                          Total = as.numeric(HD01_VD01),
                          Bach_M = as.numeric(HD01_VD09),
                          Grad_M = as.numeric(HD01_VD10),
                          Bach_F = as.numeric(HD01_VD18),
                          Grad_F = as.numeric(HD01_VD19))


# Select only relevant fields

Bach09 <- select(Bach09, 
                 HC01_EST_VC06,
                 HC01_EST_VC12,
                 HC01_EST_VC13)
Bach10 <- select(Bach10, 
                 HC01_EST_VC07,
                 HC01_EST_VC13,
                 HC01_EST_VC14)
Bach11 <- select(Bach11, 
                 HC01_EST_VC07,
                 HC01_EST_VC13,
                 HC01_EST_VC14)
Bach12 <- select(Bach12, 
                 HC01_EST_VC07,
                 HC01_EST_VC13,
                 HC01_EST_VC14)
Bach13 <- select(Bach13, 
                 HC01_EST_VC07,
                 HC01_EST_VC13,
                 HC01_EST_VC14)
Bach14 <- select(Bach14, 
                 HC01_EST_VC07,
                 HC01_EST_VC13,
                 HC01_EST_VC14)
Bach15 <- select(Bach15, 
                 HC01_EST_VC08,
                 HC01_EST_VC14,
                 HC01_EST_VC15)




# Rename relavent fields

Bach09 <- rename(Bach09,
                 Total = HC01_EST_VC06,
                 Total_Bach = HC01_EST_VC12,
                 Total_Grad = HC01_EST_VC13)
Bach10 <- rename(Bach10,
                 Total = HC01_EST_VC07,
                 Total_Bach = HC01_EST_VC13,
                 Total_Grad = HC01_EST_VC14)
Bach11 <- rename(Bach11,
                 Total = HC01_EST_VC07,
                 Total_Bach = HC01_EST_VC13,
                 Total_Grad = HC01_EST_VC14)
Bach12 <- rename(Bach12,
                 Total = HC01_EST_VC07,
                 Total_Bach = HC01_EST_VC13,
                 Total_Grad = HC01_EST_VC14)
Bach13 <- rename(Bach13,
                 Total = HC01_EST_VC07,
                 Total_Bach = HC01_EST_VC13,
                 Total_Grad = HC01_EST_VC14)
Bach14 <- rename(Bach14,
                 Total = HC01_EST_VC07,
                 Total_Bach = HC01_EST_VC13,
                 Total_Grad = HC01_EST_VC14)
Bach15 <- rename(Bach15,
                 Total = HC01_EST_VC08,
                 Total_Bach = HC01_EST_VC14,
                 Total_Grad = HC01_EST_VC15)



#Calculate Percent Bachelors for All and each race

Bach09 <- mutate(Bach09,
                 date = 2009,
                 P_Bach = ((Total * (Total_Bach/100)) + (Total * (Total_Grad/100))) / Total * 100)
Bach10 <- mutate(Bach10,
                 date = 2010,
                 P_Bach = ((Total * (Total_Bach/100)) + (Total * (Total_Grad/100))) / Total * 100)
Bach11 <- mutate(Bach11,
                 date = 2011,
                 P_Bach = ((Total * (Total_Bach/100)) + (Total * (Total_Grad/100))) / Total * 100)
Bach12 <- mutate(Bach12,
                 date = 2012,
                 P_Bach = ((Total * (Total_Bach/100)) + (Total * (Total_Grad/100))) / Total * 100)
Bach13 <- mutate(Bach13,
                 date = 2013,
                 P_Bach = ((Total * (Total_Bach/100)) + (Total * (Total_Grad/100))) / Total * 100)
Bach14 <- mutate(Bach14,
                 date = 2014,
                 P_Bach = ((Total * (Total_Bach/100)) + (Total * (Total_Grad/100))) / Total * 100)
Bach15 <- mutate(Bach15,
                 date = 2015,
                 P_Bach = (Total_Bach + Total_Grad) / Total * 100)


bach_white_09 <- mutate(bach_white_09,
                        date = 2009,
                        P_Bach_white = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_white_10 <- mutate(bach_white_10,
                        date = 2010,
                        P_Bach_white = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_white_11 <- mutate(bach_white_11,
                        date = 2011,
                        P_Bach_white = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_white_12 <- mutate(bach_white_12,
                        date = 2012,
                        P_Bach_white = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_white_13 <- mutate(bach_white_13,
                        date = 2013,
                        P_Bach_white = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_white_14 <- mutate(bach_white_14,
                        date = 2014,
                        P_Bach_white = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_white_15 <- mutate(bach_white_15,
                        date = 2015,
                        P_Bach_white = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)

bach_black_09 <- mutate(bach_black_09,
                        date = 2009,
                        P_Bach_black = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_black_10 <- mutate(bach_black_10,
                        date = 2010,
                        P_Bach_black = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_black_11 <- mutate(bach_black_11,
                        date = 2011,
                        P_Bach_black = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_black_12 <- mutate(bach_black_12,
                        date = 2012,
                        P_Bach_black = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_black_13 <- mutate(bach_black_13,
                        date = 2013,
                        P_Bach_black = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_black_14 <- mutate(bach_black_14,
                        date = 2014,
                        P_Bach_black = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_black_15 <- mutate(bach_black_15,
                        date = 2015,
                        P_Bach_black = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)

bach_asian_09 <- mutate(bach_asian_09,
                        date = 2009,
                        P_Bach_asian = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_asian_10 <- mutate(bach_asian_10,
                        date = 2010,
                        P_Bach_asian = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_asian_11 <- mutate(bach_asian_11,
                        date = 2011,
                        P_Bach_asian = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_asian_12 <- mutate(bach_asian_12,
                        date = 2012,
                        P_Bach_asian = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_asian_13 <- mutate(bach_asian_13,
                        date = 2013,
                        P_Bach_asian = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_asian_14 <- mutate(bach_asian_14,
                        date = 2014,
                        P_Bach_asian = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_asian_15 <- mutate(bach_asian_15,
                        date = 2015,
                        P_Bach_asian = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)

bach_hisp_09 <- mutate(bach_hisp_09,
                       date = 2009,
                       P_Bach_hisp = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_hisp_10 <- mutate(bach_hisp_10,
                       date = 2010,
                       P_Bach_hisp = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_hisp_11 <- mutate(bach_hisp_11,
                       date = 2011,
                       P_Bach_hisp = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_hisp_12 <- mutate(bach_hisp_12,
                       date = 2012,
                       P_Bach_hisp = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_hisp_13 <- mutate(bach_hisp_13,
                       date = 2013,
                       P_Bach_hisp = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_hisp_14 <- mutate(bach_hisp_14,
                       date = 2014,
                       P_Bach_hisp = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)
bach_hisp_15 <- mutate(bach_hisp_15,
                       date = 2015,
                       P_Bach_hisp = (Bach_M + Grad_M + Bach_F + Grad_F) / Total * 100)

# Select only fields mutated above
Bach09 <- select(Bach09, date, P_Bach)
Bach10 <- select(Bach10, date, P_Bach)
Bach11 <- select(Bach11, date, P_Bach)
Bach12 <- select(Bach12, date, P_Bach)
Bach13 <- select(Bach13, date, P_Bach)
Bach14 <- select(Bach14, date, P_Bach)
Bach15 <- select(Bach15, date, P_Bach)

bach_white_09 <- select(bach_white_09, date, P_Bach_white)
bach_white_10 <- select(bach_white_10, date, P_Bach_white)
bach_white_11 <- select(bach_white_11, date, P_Bach_white)
bach_white_12 <- select(bach_white_12, date, P_Bach_white)
bach_white_13 <- select(bach_white_13, date, P_Bach_white)
bach_white_14 <- select(bach_white_14, date, P_Bach_white)
bach_white_15 <- select(bach_white_15, date, P_Bach_white)

bach_black_09 <- select(bach_black_09, date, P_Bach_black)
bach_black_10 <- select(bach_black_10, date, P_Bach_black)
bach_black_11 <- select(bach_black_11, date, P_Bach_black)
bach_black_12 <- select(bach_black_12, date, P_Bach_black)
bach_black_13 <- select(bach_black_13, date, P_Bach_black)
bach_black_14 <- select(bach_black_14, date, P_Bach_black)
bach_black_15 <- select(bach_black_15, date, P_Bach_black)

bach_asian_09 <- select(bach_asian_09, date, P_Bach_asian)
bach_asian_10 <- select(bach_asian_10, date, P_Bach_asian)
bach_asian_11 <- select(bach_asian_11, date, P_Bach_asian)
bach_asian_12 <- select(bach_asian_12, date, P_Bach_asian)
bach_asian_13 <- select(bach_asian_13, date, P_Bach_asian)
bach_asian_14 <- select(bach_asian_14, date, P_Bach_asian)
bach_asian_15 <- select(bach_asian_15, date, P_Bach_asian)

bach_hisp_09 <- select(bach_hisp_09, date, P_Bach_hisp)
bach_hisp_10 <- select(bach_hisp_10, date, P_Bach_hisp)
bach_hisp_11 <- select(bach_hisp_11, date, P_Bach_hisp)
bach_hisp_12 <- select(bach_hisp_12, date, P_Bach_hisp)
bach_hisp_13 <- select(bach_hisp_13, date, P_Bach_hisp)
bach_hisp_14 <- select(bach_hisp_14, date, P_Bach_hisp)
bach_hisp_15 <- select(bach_hisp_15, date, P_Bach_hisp)


# Combine all datasets
Bach <- rbind(Bach09, Bach10, Bach11, Bach12, Bach13, Bach14, Bach15)
bach_white <- rbind(bach_white_09, bach_white_10, bach_white_11, bach_white_12, bach_white_13, bach_white_14, bach_white_15)
bach_black <- rbind(bach_black_09, bach_black_10, bach_black_11, bach_black_12, bach_black_13, bach_black_14, bach_black_15)
bach_asian <- rbind(bach_asian_09, bach_asian_10, bach_asian_11, bach_asian_12, bach_asian_13, bach_asian_14, bach_asian_15)
bach_hisp <- rbind(bach_hisp_09, bach_hisp_10, bach_hisp_11, bach_hisp_12, bach_hisp_13, bach_hisp_14, bach_hisp_15)

bach1 <- merge(x = Bach, y = bach_white, by = "date", all.x = TRUE)
bach2 <- merge(x = bach1, y = bach_black, by = "date", all.x = TRUE)
bach3 <- merge(x = bach2, y = bach_asian, by = "date", all.x = TRUE)
State_EA <- merge(x = bach3, y = bach_hisp, by = "date", all.x = TRUE)

# Write to csv
write.csv(State_EA, file = "G:/DC Policy Center/Educational Attainment/Data/Tab/Tidy/State_EA.csv", row.names = FALSE)



# Census Tract Educational Attainment
# Import Datasets
CT_EA_09 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/Census_Tract/Educational_Attainment/ACS_09_5YR_S1501_with_ann.csv")
CT_EA_15 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/Census_Tract/Educational_Attainment/ACS_15_5YR_S1501_with_ann.csv")

CT_EA_white_09 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/Census_Tract/Educational_Attainment_white/ACS_09_5YR_C15002A_with_ann.csv")
CT_EA_white_15 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/Census_Tract/Educational_Attainment_white/ACS_15_5YR_C15002A_with_ann.csv")

CT_EA_black_09 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/Census_Tract/Educational_Attainment_black/ACS_09_5YR_C15002B_with_ann.csv")
CT_EA_black_15 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/Census_Tract/Educational_Attainment_black/ACS_15_5YR_C15002B_with_ann.csv")

CT_EA_asian_09 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/Census_Tract/Educational_Attainment_asian/ACS_09_5YR_C15002D_with_ann.csv")
CT_EA_asian_15 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/Census_Tract/Educational_Attainment_asian/ACS_15_5YR_C15002D_with_ann.csv")

CT_EA_hisp_09 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/Census_Tract/Educational_Attainment_hisp/ACS_09_5YR_C15002I_with_ann.csv")
CT_EA_hisp_15 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/Census_Tract/Educational_Attainment_hisp/ACS_15_5YR_C15002I_with_ann.csv")


# Remove annotations row
CT_EA_09 <- CT_EA_09[-1,]
CT_EA_15 <- CT_EA_15[-1,]

CT_EA_white_09 <- CT_EA_white_09[-1,]
CT_EA_white_15 <- CT_EA_white_15[-1,]

CT_EA_black_09 <- CT_EA_black_09[-1,]
CT_EA_black_15 <- CT_EA_black_15[-1,]

CT_EA_asian_09 <- CT_EA_asian_09[-1,]
CT_EA_asian_15 <- CT_EA_asian_15[-1,]

CT_EA_hisp_09 <- CT_EA_hisp_09[-1,]
CT_EA_hisp_15 <- CT_EA_hisp_15[-1,]


# Transform relavent fields to numeric
CT_EA_09 <- transform(CT_EA_09,
                    GEOID = as.character(GEO.id2),
                    Total_09 = as.numeric(HC01_EST_VC06),
                    Bach_09 = as.numeric(HC01_EST_VC12),
                    Grad_09 = as.numeric(HC01_EST_VC13))
CT_EA_15 <- transform(CT_EA_15,
                    GEOID = as.character(GEO.id2),
                    Total_15 = as.numeric(HC01_EST_VC08),
                    Bach_15 = as.numeric(HC01_EST_VC14),
                    Grad_15 = as.numeric(HC01_EST_VC15))

CT_EA_white_09 <- transform(CT_EA_white_09,
                            GEOID = as.character(GEO.id2),
                            Total_white_09 = as.numeric(HD01_VD01),
                            Bach_m_white_09 = as.numeric(HD01_VD06),
                            Bach_f_white_09 = as.numeric(HD01_VD11))
CT_EA_white_15 <- transform(CT_EA_white_15,
                            GEOID = as.character(GEO.id2),
                            Total_white_15 = as.numeric(HD01_VD01),
                            Bach_m_white_15 = as.numeric(HD01_VD06),
                            Bach_f_white_15 = as.numeric(HD01_VD11))

CT_EA_black_09 <- transform(CT_EA_black_09,
                            GEOID = as.character(GEO.id2),
                            Total_black_09 = as.numeric(HD01_VD01),
                            Bach_m_black_09 = as.numeric(HD01_VD06),
                            Bach_f_black_09 = as.numeric(HD01_VD11))
CT_EA_black_15 <- transform(CT_EA_black_15,
                            GEOID = as.character(GEO.id2),
                            Total_black_15 = as.numeric(HD01_VD01),
                            Bach_m_black_15 = as.numeric(HD01_VD06),
                            Bach_f_black_15 = as.numeric(HD01_VD11))

CT_EA_asian_09 <- transform(CT_EA_asian_09,
                            GEOID = as.character(GEO.id2),
                            Total_asian_09 = as.numeric(HD01_VD01),
                            Bach_m_asian_09 = as.numeric(HD01_VD06),
                            Bach_f_asian_09 = as.numeric(HD01_VD11))
CT_EA_asian_15 <- transform(CT_EA_asian_15,
                            GEOID = as.character(GEO.id2),
                            Total_asian_15 = as.numeric(HD01_VD01),
                            Bach_m_asian_15 = as.numeric(HD01_VD06),
                            Bach_f_asian_15 = as.numeric(HD01_VD11))

CT_EA_hisp_09 <- transform(CT_EA_hisp_09,
                           GEOID = as.character(GEO.id2),
                           Total_hisp_09 = as.numeric(HD01_VD01),
                           Bach_m_hisp_09 = as.numeric(HD01_VD06),
                           Bach_f_hisp_09 = as.numeric(HD01_VD11))
CT_EA_hisp_15 <- transform(CT_EA_hisp_15,
                           GEOID = as.character(GEO.id2),
                           Total_hisp_15 = as.numeric(HD01_VD01),
                           Bach_m_hisp_15 = as.numeric(HD01_VD06),
                           Bach_f_hisp_15 = as.numeric(HD01_VD11))

# Select only relevant fields
CT_EA_09 <- select(CT_EA_09,
                    GEOID,
                    Total_09,
                    Bach_09,
                    Grad_09)
CT_EA_15 <- select(CT_EA_15,
                   GEOID,
                   Total_15,
                   Bach_15,
                   Grad_15)

CT_EA_white_09 <- select(CT_EA_white_09,
                   GEOID,
                   Total_white_09,
                   Bach_m_white_09,
                   Bach_f_white_09)
CT_EA_white_15 <- select(CT_EA_white_15,
                   GEOID,
                   Total_white_15,
                   Bach_m_white_15,
                   Bach_f_white_15)

CT_EA_black_09 <- select(CT_EA_black_09,
                         GEOID,
                         Total_black_09,
                         Bach_m_black_09,
                         Bach_f_black_09)
CT_EA_black_15 <- select(CT_EA_black_15,
                         GEOID,
                         Total_black_15,
                         Bach_m_black_15,
                         Bach_f_black_15)

CT_EA_asian_09 <- select(CT_EA_asian_09,
                         GEOID,
                         Total_asian_09,
                         Bach_m_asian_09,
                         Bach_f_asian_09)
CT_EA_asian_15 <- select(CT_EA_asian_15,
                         GEOID,
                         Total_asian_15,
                         Bach_m_asian_15,
                         Bach_f_asian_15)

CT_EA_hisp_09 <- select(CT_EA_hisp_09,
                        GEOID,
                        Total_hisp_09,
                        Bach_m_hisp_09,
                        Bach_f_hisp_09)
CT_EA_hisp_15 <- select(CT_EA_hisp_15,
                        GEOID,
                        Total_hisp_15,
                        Bach_m_hisp_15,
                        Bach_f_hisp_15)



#Calculate Percent Bachelors for All and each race
CT_EA_09 <- mutate(CT_EA_09,
                   Bach_09 = Total_09 * (Bach_09/ 100),
                   Grad_09 = Total_09 * (Grad_09 / 100),
                   P_Bach_09 = (Bach_09 + Grad_09) / Total_09 *100)
CT_EA_15 <- mutate(CT_EA_15,
                 P_Bach_15 = (Bach_15 + Grad_15) / Total_15 *100)

CT_EA_white_09 <- mutate(CT_EA_white_09,
                         P_Bach_white_09 = (Bach_m_white_09 + Bach_f_white_09) / Total_white_09 * 100)
CT_EA_white_15 <- mutate(CT_EA_white_15,
                         P_Bach_white_15 = (Bach_m_white_15 + Bach_f_white_15) / Total_white_15 * 100)

CT_EA_black_09 <- mutate(CT_EA_black_09,
                         P_Bach_black_09 = (Bach_m_black_09 + Bach_f_black_09) / Total_black_09 * 100)
CT_EA_black_15 <- mutate(CT_EA_black_15,
                         P_Bach_black_15 = (Bach_m_black_15 + Bach_f_black_15) / Total_black_15 * 100)

CT_EA_asian_09 <- mutate(CT_EA_asian_09,
                         P_Bach_asian_09 = (Bach_m_asian_09 + Bach_f_asian_09) / Total_asian_09 * 100)
CT_EA_asian_15 <- mutate(CT_EA_asian_15,
                         P_Bach_asian_15 = (Bach_m_asian_15 + Bach_f_asian_15) / Total_asian_15 * 100)

CT_EA_hisp_09 <- mutate(CT_EA_hisp_09,
                        P_Bach_hisp_09 = (Bach_m_hisp_09 + Bach_f_hisp_09) / Total_hisp_09 * 100)
CT_EA_hisp_15 <- mutate(CT_EA_hisp_15,
                        P_Bach_hisp_15 = (Bach_m_hisp_15 + Bach_f_hisp_15) / Total_hisp_15 * 100)


#Table Join
CT_EA_All <- merge(x = CT_EA_15, y = CT_EA_09, by = "GEOID", all.x = TRUE)
CT_EA_White <- merge(x = CT_EA_white_15, y = CT_EA_white_09, by = "GEOID", all.x = TRUE)
CT_EA_black <- merge(x = CT_EA_black_15, y = CT_EA_black_09, by = "GEOID", all.x = TRUE)
CT_EA_asian <- merge(x = CT_EA_asian_15, y = CT_EA_asian_09, by = "GEOID", all.x = TRUE)
CT_EA_hisp <- merge(x = CT_EA_hisp_15, y = CT_EA_hisp_09, by = "GEOID", all.x = TRUE)

CT1 <- merge(x = CT_EA_All, y = CT_EA_White, by = "GEOID", all.x = TRUE)
CT2 <- merge(x = CT1, y = CT_EA_black, by = "GEOID", all.x = TRUE)
CT3 <- merge(x = CT2, y = CT_EA_asian, by = "GEOID", all.x = TRUE)
CT_EA <- merge(x = CT3, y = CT_EA_hisp, by = "GEOID", all.x = TRUE)

write.csv(CT_EA, file = "G:/DC Policy Center/Educational Attainment/Data/Tab/Tidy/CT_EA.csv", row.names = FALSE)

# Calculate Difference Fields
CT_EA <- mutate(CT_EA,
                D_Total = Total_15 - Total_09,
                Bach_15 = Bach_15 + Grad_15,
                Bach_09 = Bach_09 + Grad_09,
                D_Bach = Bach_15 - Bach_09,
                C_Bach = (Bach_15 - Bach_09) / Bach_09 * 100,
                C_P_Bach = (P_Bach_15 - P_Bach_09) / P_Bach_09 * 100,
                D_Total_white = Total_white_15 - Total_white_09,
                Bach_white_15 = Bach_m_white_15 + Bach_f_white_15,
                Bach_white_09 = Bach_m_white_09 + Bach_f_white_09,
                D_Bach_white = Bach_white_15 - Bach_white_09,
                C_Bach_white = (Bach_white_15 - Bach_white_09) / Bach_white_09 * 100,
                C_P_Bach_white = (P_Bach_white_15 - P_Bach_white_09) / P_Bach_white_09 * 100,
                D_Total_black = Total_black_15 - Total_black_09,
                Bach_black_15 = Bach_m_black_15 + Bach_f_black_15,
                Bach_black_09 = Bach_m_black_09 + Bach_f_black_09,
                D_Bach_black = Bach_black_15 - Bach_black_09,
                C_Bach_black = (Bach_black_15 - Bach_black_09) / Bach_black_09 * 100,
                C_P_Bach_black = (P_Bach_black_15 - P_Bach_black_09) / P_Bach_black_09 * 100,
                D_Total_asian = Total_asian_15 - Total_asian_09,
                Bach_asian_15 = Bach_m_asian_15 + Bach_f_asian_15,
                Bach_asian_09 = Bach_m_asian_09 + Bach_f_asian_09,
                D_Bach_asian = Bach_asian_15 - Bach_asian_09,
                C_Bach_asian = (Bach_asian_15 - Bach_asian_09) / Bach_asian_09 * 100,
                C_P_Bach_asian = (P_Bach_asian_15 - P_Bach_asian_09) / P_Bach_asian_09 * 100,
                D_Total_hisp = Total_hisp_15 - Total_hisp_09,
                Bach_hisp_15 = Bach_m_hisp_15 + Bach_f_hisp_15,
                Bach_hisp_09 = Bach_m_hisp_09 + Bach_f_hisp_09,
                D_Bach_hisp = Bach_hisp_15 - Bach_hisp_09,
                C_Bach_hisp = (Bach_hisp_15 - Bach_hisp_09) / Bach_hisp_09 * 100,
                C_P_Bach_hisp = (P_Bach_hisp_15 - P_Bach_hisp_09) / P_Bach_hisp_09 * 100)
                
# Rearrange columns               
CT_EA <- select(CT_EA,
                GEOID,
                Total_15,
                P_Bach_15,
                Total_09,
                P_Bach_09,
                D_Total, 
                Bach_15, 
                Bach_09, 
                D_Bach, 
                C_Bach, 
                C_P_Bach,
                Total_white_15,
                P_Bach_white_15,
                Total_white_09,
                P_Bach_white_09,
                D_Total_white, 	
                Bach_white_15, 	
                Bach_white_09, 	
                D_Bach_white, 	
                C_Bach_white, 	
                C_P_Bach_white,
                Total_black_15,
                P_Bach_black_15,
                Total_black_09,
                P_Bach_black_09,
                D_Total_black, 
                Bach_black_15, 
                Bach_black_09, 
                D_Bach_black,
                C_Bach_black, 
                C_P_Bach_black,
                Total_asian_15,
                P_Bach_asian_15,
                Total_asian_09,
                P_Bach_asian_09,
                D_Total_asian, 
                Bach_asian_15, 
                Bach_asian_09, 
                D_Bach_asian,
                C_Bach_asian, 
                C_P_Bach_asian, 
                Total_hisp_15,
                P_Bach_hisp_15,
                Total_hisp_09,
                P_Bach_hisp_09,
                D_Total_hisp, 
                Bach_hisp_15, 
                Bach_hisp_09, 
                D_Bach_hisp, 
                C_Bach_hisp, 
                C_P_Bach_hisp)


# Census Tract Income
# Import datasets
CT_All_09 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/Census_Tract/Median_Household_Income/ACS_09_5YR_B19013_with_ann.csv")
CT_All_15 <- read_csv("G:/DC Policy Center/Educational Attainment/Data/Tab/Census_Tract/Median_Household_Income/ACS_15_5YR_B19013_with_ann.csv")


# Remove Annotations row
CT_All_09 <- CT_All_09[-1,]
CT_All_15 <- CT_All_15[-1,]


# Rename attributes
CT_All_09 <- rename(CT_All_09, GEOID = GEO.id2, MHI_ALL_09 = HD01_VD01)
CT_All_15 <- rename(CT_All_15, GEOID = GEO.id2, MHI_ALL_15 = HD01_VD01)


# Select MHI and GEOID
CT_All_09 <- select(CT_All_09, GEOID, MHI_ALL_09)
CT_All_15 <- select(CT_All_15, GEOID, MHI_ALL_15)


# Table join income datasets
CT_Income <- merge(x = CT_All_15, y = CT_All_09, by = "GEOID", all.x = TRUE)

CT_Income <- mutate(CT_Income,
                    D_Income = 0,
                    C_Income = 0)


# Convert Geoid to text
CT_Income <- transform(CT_Income, GEOID = as.character(GEOID))



# Table join income and education
CT_EA_Income <- merge(x = CT_EA, y = CT_Income, by = "GEOID", all.x = TRUE)


write.xlsx(CT_EA_Income, file = "G:/DC Policy Center/Educational Attainment/Data/Tab/Tidy/CT_EA_Income.xlsx",
           sheetName = "CT_EA_Income",
           row.names = FALSE)



