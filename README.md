# uber_data

# code to format the date

```
uber_data$Date.Time <- as.POSIXct(uber_data$Date.Time, format = "%m/%d/%Y %H:%M:%S")

uber_data$day_of_week <- weekdays(as.Date(uber_data$Date.Time))
  
uber_data$week <- week(as.Date(uber_data$Date.Time))
```

I used as.POSIXct to fomat the date into month, day, and year. 
I also used weekdays() and week() to get the specific day of the week and week of the year.

# code to make different tables

```trips_by_month_week <- uber_data %>%
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
  ```
  I created 8 different tables to make it easier to see how each data related. This made it easier to create pivot tables and graphs in the shiny app based on what was in these tables I created.
  
  # code to create csv files 
  
  ```
  write.csv(trips_by_hour, file = "trips_by_hour.csv")
write.csv(trips_by_hour_month, file = "trips_by_hour_month.csv")
write.csv(trips_by_full_month, file = "trips_by_full_month.csv")
write.csv(trips_by_day_month, file = "trips_by_day_month.csv") 
write.csv(trips_by_base_month, file = "trips_by_base_month.csv")
write.csv(trips_by_hour_day, file = "trips_by_hour_day.csv")
write.csv(trips_by_base_day, file = "trips_by_base_day.csv")
write.csv(trips_by_month_week, file = "trips_by_month_week.csv")
```
I used the tables that I made and changed them all into csv files and created another r script to run just using these new csv files. This allowed R to run much faster and take up less memory. 

