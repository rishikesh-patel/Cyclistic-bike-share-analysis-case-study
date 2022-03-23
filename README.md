# Cyclistic bike-share analysis case study
## Google Data Analytics Professional Certificate - Capstone Project

### Introduction
Welcome to the Cyclistic bike-share analysis case study! In this case study, you will perform many real-world tasks of a junior
data analyst. You will work for a fictional company, Cyclistic, and meet different characters and team members. In order to
answer the key business questions, you will follow the steps of the data analysis process: ask, prepare, process, analyze,
share, and act. Along the way, the Case Study Roadmap tables — including guiding questions and key tasks — will help you
stay on the right path.
By the end of this lesson, you will have a portfolio-ready case study. Download the packet and reference the details of this
case study anytime. Then, when you begin your job hunt, your case study will be a tangible way to demonstrate your
knowledge and skills to potential employers.

### Scenario
You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director
of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore,
your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights,
your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives
must approve your recommendations, so they must be backed up with compelling data insights and professional data
visualizations.
### Characters and teams
● Cyclistic: A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself
apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with
disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about
8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to
commute to work each day.

● Lily Moreno: The director of marketing and your manager. Moreno is responsible for the development of campaigns
and initiatives to promote the bike-share program. These may include email, social media, and other channels.

● Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analyzing, and
reporting data that helps guide Cyclistic marketing strategy. You joined this team six months ago and have been busy
learning about Cyclistic’s mission and business goals — as well as how you, as a junior data analyst, can help Cyclistic
achieve them.

● Cyclistic executive team: The notoriously detail-oriented executive team will decide whether to approve the
recommended marketing program.

### About the company
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that
are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and
returned to any other station in the system anytime.
Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments.
One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes,
and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers
who purchase annual memberships are Cyclistic members.
Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the
pricing flexibility helps Cyclistic attract more customers, Moreno believes that maximizing the number of annual members will
be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a
very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic
program and have chosen Cyclistic for their mobility needs.
Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to
do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why
casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are
interested in analyzing the Cyclistic historical bike trip data to identify trends.

## Source of the datasets
We will be using a public dataset published by Divvy a bike sharing company in Chicago:
1. About [Divvy](https://www.divvybikes.com/about)
2. Original [link](https://divvy-tripdata.s3.amazonaws.com/index.html) to the dataset.
3. Data license: Cyclistic is a fictional company. For the purposes of this case study,
the datasets are appropriate and will enable you to answer the business questions. The data has been made available by
Motivate International Inc. under this [license.](https://ride.divvybikes.com/data-license-agreement)

Data Visualization: [Tableau](https://public.tableau.com/views/Cyclisticbike-shareanalysis_16456039688820/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link)

## Preparing Data for Analysis
For this project, I've used previous 12 months of Cyclistic trip data from April 2020 to March 2021, From the  [link](https://divvy-tripdata.s3.amazonaws.com/index.html)


```
install.packages("tidyverse")
install.packages("lubridate")
install.packages("janitor")
install.packages("scales")
library(janitor)
library(scales)
library(dplyr)
library(tidyverse)  #helps wrangle data
library(lubridate)  #helps wrangle date attributes
```
```
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
```
```
#Combining all datasets and assigning to (trip_data_fy_2021)
trip_data_fy_2021 <- rbind(td1, td2, td3, td4, td5, td6, td7, td8, td9, td10, td11, td12)
```
## Processing and Analysis of Data
Here, I will be transforming and organizing data by adding new columns, extracting information and removing bad data and duplicates.
```
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
```
```
write.csv(case_study_1, file = "case_study_1", row.names = FALSE)
```
**Tableau Dashboard**

Visualizations built in a dashboard. 
![Dashboard 1](https://user-images.githubusercontent.com/53640666/158020449-dacc2015-b691-41eb-8c62-3e49bcd19f44.png)

