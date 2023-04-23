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
  
  trips_by_lat_lon <- uber_data %>%
  group_by(lat = Lat, lon = Lon) %>%
  summarise(trips = n()) 
  ```
  I created 9 different tables to make it easier to see how each data related. This made it easier to create pivot tables and graphs in the shiny app based on what was in these tables I created.
  
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
write.csv(trips_by_lat_lon, file = "trips_by_lat_lon.csv")
```
I used the tables that I made and changed them all into csv files and created another r script to run just using these new csv files. This allowed R to run much faster and take up less memory. 

# code to explain outputs
```
tabPanel("table",
             fluidRow(
               column(2.5, textOutput("text_output1")),
               column(3.5,DT::dataTableOutput("table", width = "100%")))),

tabPanel("plot1",
             fluidRow(
               column(7, textOutput("text_output2")),
               column(8,plotOutput('plot_01', width = '1000px')))),

tabPanel("model", 
             fluidRow(
               column(12, textOutput("text_output13")),
               column(12, plotOutput("model1"))))


```

I created different outputs to show text, tables, graphs, and heatmaps.

# code to show graphs, tables, heatmaps, leaflet, and model

```
output$text_output1 <- renderText({ text1 })
  
  output$table <- DT::renderDataTable(trips_by_hour[,c("hour","trips")],options = list(pageLength = 4))
  
  output$text_output2 <- renderText({ text2 })
  
    output$plot_01 <- renderPlot({
    ggplot(trips_by_hour_month, aes(x = hour, y = trips, fill = month)) +
      geom_col() +
      xlab("hour") +
      ylab("trips") +
      ggtitle("trips by the hour by month")
    
    
  })
  
  output$heatmap_1 <-renderPlot({
    ggplot(trips_by_hour_day, aes(x = hour, y = day, fill = trips)) +
      geom_tile() + 
      xlab("hour") + 
      ylab("day")  
  })
  
  output$leaf <- renderLeaflet({
    leaflet(head(trips_by_lat_lon, 2000)) %>%
      addTiles() %>%
      addMarkers(~lon, ~lat, popup = "trips")
  })
  
  output$model1 <- renderPlot({
    model <- lm(trips ~ month, data = trips_by_full_month)
    predictions <- predict(model)
    observed <- trips_by_full_month$trips
    plot(predictions, observed, xlab = "Predicted", ylab = "Observed")
```

I created different ggplots by using geom_col() and geom_tile(). To create the table I used renderDataTable().  I used stacked bar graphs and regular bar graphs to show the different data. 


# shinny url
http://jasondonohue20.shinyapps.io/UberData?_ga=2.128592206.358588650.1682270343-746115546.1677884294
