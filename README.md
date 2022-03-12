# Cyclistic bike-share analysis case study
## Google Data Analytics Professional Certificate - Capstone Project
## Source of the datasets
We will be using a public dataset published by Divvy a bike sharing company in Chicago:
1. About [Divvy](https://www.divvybikes.com/about)
2. Original [link](https://divvy-tripdata.s3.amazonaws.com/index.html) to the dataset.
3. Data license

Data Visualization: [Tableau](https://public.tableau.com/views/Cyclisticbike-shareanalysis_16456039688820/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link)

install.packages("tidyverse")
install.packages("lubridate")
install.packages("janitor")
install.packages("scales")
library(janitor)
library(scales)
library(dplyr)
library(tidyverse)  #helps wrangle data
library(lubridate)  #helps wrangle date attributes

#loading all datasets
td1 <- read.csv("202004-divvy-tripdata.csv")
td2 <- read.csv("202005-divvy-tripdata.csv")
td3 <- read.csv("202006-divvy-tripdata.csv")
td4 <- read.csv("202007-divvy-tripdata.csv")
td5 <- read.csv("202008-divvy-tripdata.csv")
td6 <- read.csv("202009-divvy-tripdata.csv")
td7 <- read.csv("202010-divvy-tripdata.csv")
td8 <- read.csv("202011-divvy-tripdata.csv")
td9 <- read.csv("202012-divvy-tripdata.csv")
td10 <- read.csv("202101-divvy-tripdata.csv")
td11 <- read.csv("202102-divvy-tripdata.csv")
td12 <- read.csv("202103-divvy-tripdata.csv")

#Combining all datasets and assigning to (trip_data_fy_2021)
trip_data_fy_2021 <- rbind(td1, td2, td3, td4, td5, td6, td7, td8, td9, td10, td11, td12)

#Removing any empty rows or columns present and assigning to (new_trip_data_fy_2021)
new_trip_data_fy_2021 <- remove_empty(trip_data_fy_2021, which=c("rows", "cols"))

#omitting NA values in the entire data frame
new_trip_data_fy_2021 <- na.omit(new_trip_data_fy_2021)

#Removing duplicates and assigning to (new_trip_data_fy_2021_no_dups)
new_trip_data_fy_2021_no_dups <- new_trip_data_fy_2021[!duplicated(new_trip_data_fy_2021$ride_id), ]

#assigning (new_trip_data_fy_2021_no_dups) dataset to case_study_1
case_study_1 <- new_trip_data_fy_2021_no_dups

#creating a column called (ride_length)
case_study_1 <- case_study_1 %>% 
  mutate (ride_length = difftime(ended_at,started_at, units = "mins"))
case_study_1

#creating a column called (weekday)
case_study_1 <- case_study_1 %>% 
  mutate(weekday=strftime(case_study_1$ended_at, "%A"))


#creating a columns called (date, month, date, year)
case_study_1$date <- as.Date(case_study_1$started_at)
case_study_1$month <- format(as.Date(case_study_1$started_at),"%m")
case_study_1$Date <- format(as.Date(case_study_1$started_at),"%d")
case_study_1$year <- format(as.Date(case_study_1$started_at),"%Y")

# dataset for visualization on Tableau
write.csv(case_study_1, file = "case_study_1", row.names = FALSE)
![Dashboard 1](https://user-images.githubusercontent.com/53640666/158020449-dacc2015-b691-41eb-8c62-3e49bcd19f44.png)

