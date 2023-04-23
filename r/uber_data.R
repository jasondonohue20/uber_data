library(tidyverse)
library(ggplot2)
library(dplyr)
library(shiny)
library(lubridate)


uber_data_apr <- read.csv("original data/uber-raw-data-apr14.csv") 
uber_data_aug <- read.csv("original data/uber-raw-data-aug14.csv")
uber_data_jul <- read.csv("original data/uber-raw-data-jul14.csv")
uber_data_jun <- read.csv("original data/uber-raw-data-jun14.csv")
uber_data_may <- read.csv("original data/uber-raw-data-may14.csv")
uber_data_sep <- read.csv("original data/uber-raw-data-sep14.csv")

uber_data <- rbind(uber_data_apr,uber_data_aug, uber_data_jul, 
                   uber_data_jun, uber_data_may, uber_data_sep 
)


uber_data$Date.Time <- as.POSIXct(uber_data$Date.Time, format = "%m/%d/%Y %H:%M:%S")

uber_data$day_of_week <- weekdays(as.Date(uber_data$Date.Time))

uber_data$week <- week(as.Date(uber_data$Date.Time))

trips_by_month_week <- uber_data %>%
  group_by(month = month(Date.Time), week) %>%
  summarise(trips = n()) %>%
  arrange(month)

trips_by_hour <- uber_data %>%
  group_by(hour = hour(Date.Time)) %>%
  summarise(trips = n()) %>%
  arrange(hour)

trips_by_hour_month <- uber_data %>%
  group_by(hour = hour(Date.Time), month = month(Date.Time, label = TRUE)) %>%
  summarise(trips = n()) %>%
  arrange(hour, month)

trips_by_full_month <- uber_data %>%
  group_by(day = day(Date.Time), month = month(Date.Time, label = TRUE)) %>%
  summarise(trips = n()) %>%
  arrange(day)


trips_by_day_month <- uber_data %>%
  group_by(day_of_week, month = month(Date.Time, label = TRUE)) %>%
  summarise(trips = n()) %>%
  arrange(month)

trips_by_base_month <- uber_data %>%
  group_by(base = Base, month = month(Date.Time, label = TRUE)) %>%
  summarise(trips = n()) %>%
  arrange(month)

trips_by_hour_day <- uber_data %>%
  group_by(day = day(Date.Time), hour = hour(Date.Time)) %>%
  summarise(trips = n()) %>%
  arrange(day, hour)

trips_by_base_day <- uber_data %>%
  group_by(base = Base, day_of_week) %>%
  summarise(trips = n()) %>%
  arrange(base, day_of_week)

trips_by_lat_lon <- uber_data %>%
  group_by(lat = Lat, lon = Lon) %>%
  summarise(trips = n()) 

write.csv(trips_by_hour, file = "trips_by_hour.csv")
write.csv(trips_by_hour_month, file = "trips_by_hour_month.csv")
write.csv(trips_by_full_month, file = "trips_by_full_month.csv")
write.csv(trips_by_day_month, file = "trips_by_day_month.csv") 
write.csv(trips_by_base_month, file = "trips_by_base_month.csv")
write.csv(trips_by_hour_day, file = "trips_by_hour_day.csv")
write.csv(trips_by_base_day, file = "trips_by_base_day.csv")
write.csv(trips_by_month_week, file = "trips_by_month_week.csv")
write.csv(trips_by_lat_lon, file = "trips_by_lat_lon.csv")

