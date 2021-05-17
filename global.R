library(shiny)
library(tidyverse)
library(plyr)
# data from https://data.oecd.org/agroutput/meat-consumption.htm
meat <- read_csv('meat_consumption.csv')%>%select(-c('INDICATOR','Flag Codes','FREQUENCY'))%>%
  pivot_wider(names_from = MEASURE,values_from=Value)%>%filter(SUBJECT!="SHEEP",THND_TONNE>1)%>%
  mutate(num_animals_total=case_when(
    SUBJECT=="BEEF" ~ ((THND_TONNE*2204.62*1000)/750),
    SUBJECT=="PIG" ~ ((THND_TONNE*2204.62*1000)/184),
    SUBJECT=="POULTRY" ~ ((THND_TONNE*2204.62*1000)/(.725*5.7))
  ))
## Expand below for explanation/sources for calculations: 
{
# to convert from thousands of metric tonnes to number of animals:
#multiply by 2204.62 to convert from metric tonnes to thousands of pounds,
#then by 1000 to put in pounds, then divide by average carcass weight for beef and pigs, or
#'ready to cook weight' for poultry. 
#sources: cattle: https://extension.sdstate.edu/how-much-meat-can-you-expect-fed-steer
#Pigs: https://www.gourmetsleuth.com/articles/detail/pork-cut-yield-per-hog#:~:text=an%20average%20hog.-,Pork%20Carcass%20Breakdown,skin%2C%20fat%2C%20and%20bone.
#Poultry: overwhelming majority of poultry are chickens, so using chicken statistics
# median live weight over since 1990: https://www.chickencheck.in/wp-content/uploads/2017/03/Industry-gains-in-bird-health-over-time-1990-to-2016.pdf
#conversion rate (72.5%) from live weight to "ready to cook weight": https://extension.umn.edu/small-scale-poultry/getting-started-broilers 
  }
type <- c("Kilograms consumed per person","Thousands of metric tons consumed","Estimated number of individual animals consumed")
vars <- c('KG_CAP','THND_TONNE',"num_animals_total")
animal_list <- c('Beef/Cattle',"Pork/Pigs","Poultry/Birds")
countries <- {c( "BRICS"= "BRICS (Brazil, Russia, India, China, & South Africa) ",
"OECD"= "OECD - Total",
"WLD" = "World",
"ARG" = "Argentina",
"AUS" = "Australia",
"BRA" = "Brazil",
"CAN" = "Canada",
"CHE" = "Switzerland",
"CHL" = "Chile",
"CHN" = "China" ,
"COL" = "Colombia",
"EGY" = "Egypt",
"ETH" = "Ethiopia",
"GBR" = "United Kingdom",
"IDN" = "Indonesia",
"IND" = "India",
"IRN" = "Iran",
"ISR" = "Israel",
"JPN" = "Japan",
"KAZ" = "Kazakhstan",
"KOR" = "Korea",
"MEX" = "Mexico",
"MYS" = "Malaysia",
"NGA" = "Nigeria",
"NOR" = "Norway",
"NZL" = "New Zealand",
"PAK" = "Pakistan",
"PER" = "Peru",
"PHL" = "Philippines",
"PRY" = "Paraguay",
"RUS" = "Russia",
"SAU" = "Saudi Arabia",
"THA" = "Thailand",
"TUR" = "Turkey",
"UKR" = "Ukraine",
"USA" = "United States",
"VNM" = "Vietnam",
"ZAF" = "South Africa")}
meat <- meat%>%mutate(LOCATION=revalue(as.factor(LOCATION),countries),
                      Type_of_Animal=SUBJECT)%>%
  select(-c("SUBJECT"))
