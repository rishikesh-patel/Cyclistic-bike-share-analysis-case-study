install.packages("tidyverse")
install.packages("lubridate")
install.packages("janitor")
install.packages("scales")
library(janitor)
library(scales)
library(dplyr)
library(tidyverse)  #helps wrangle data
library(lubridate)  #helps wrangle date attributes
library(ggplot2)#helps visualize data
getwd() #displays your working directory
setwd("/Users/rkpre/Documents/Case_study_1")
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

trip_data_fy_2021 <- rbind(td1, td2, td3, td4, td5, td6, td7, td8, td9, td10, td11, td12)

new_trip_data_fy_2021 <- remove_empty(trip_data_fy_2021, which=c("rows", "cols"))

new_trip_data_fy_2021 <- na.omit(trip_data_fy_2021)

new_trip_data_fy_2021_no_dups <- new_trip_data_fy_2021[!duplicated(new_trip_data_fy_2021$ride_id), ]

new_trip_data_fy_2021_no_dups %>%
  count(rideable_type)

trip_data_fy_2021 %>% 
  count(day_of_week)

case_study_1 <- new_trip_data_fy_2021_no_dups

case_study_1 <- case_study_1 %>% 
  mutate (ride_length = difftime(ended_at,started_at, units = "mins"))
case_study_1

case_study_1 <- case_study_1 %>% 
  mutate(weekday=strftime(case_study_1$ended_at, "%A"))

case_study_1$date <- as.Date(case_study_1$started_at)
case_study_1$month <- format(as.Date(case_study_1$started_at),"%m")
case_study_1$Datd <- format(as.Date(case_study_1$started_at),"%d")
case_study_1$year <- format(as.Date(case_study_1$started_at),"%Y")

write.csv(case_study_1,"C:\\Users\\rkpre\\Documents\\case_study_1.csv")