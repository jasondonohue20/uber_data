library(tidyverse)
library(ggplot2)
library(dplyr)
library(shiny)
library(lubridate)
library(leaflet)




trips_by_day_month <- read.csv("csv files/trips_by_day_month.csv")
trips_by_full_month <- read.csv("csv files/trips_by_full_month.csv")
trips_by_hour <- read.csv("csv files/trips_by_hour.csv")
trips_by_hour_month <- read.csv("csv files/trips_by_hour_month.csv")
trips_by_base_month <- read.csv("csv files/trips_by_base_month.csv")
trips_by_base_day <- read.csv("csv files/trips_by_base_day.csv")
trips_by_hour_day <- read.csv("csv files/trips_by_hour_day.csv")
trips_by_month_week <- read.csv("csv files/trips_by_month_week.csv")
trips_by_lat_lon <- read.csv("csv files/trips_by_lat_lon.csv")


text1 <- "Every graph I made I used geom_col to create the graphs. I created a table to show how many trips there are every hour. This data shows trips from hour 0-23 in the data.  "
text2 <- "I created a graph to show every trip by the hour by month. Each month shows a different color to know what data coresponds to each color. The data shows that with every month combined hour 17 is the busiest of them all"
text3 <- "I created a graph to show trips by the hour. The graph is very similar to the trips by hour and month, but I didn't include months in this graph. The graph just displays the total of trips compared to hour for every month combined. "
text4 <- "I created a graph that shows trips by the day by month. I did the same thing as the trips by hour by month and had different colors for each month to show what data goes with that month. Thursday and Fridays are pretty similar when it comes to which days are the busiest overall. "
text5 <- "The next 6 graphs show the amount of trips taken every day compared to each month. I filtered each graph to show which data went with which specific month so it would be easier to visualize how many trips there were each day. "
text6 <- "I created a table to show the amount of trips by days by month. This table can be filtered to show days in order, trips in order, and month in order. the table makes it easy to understand how the data changes every month. "
text7 <- "I created  graph to show base compared to trips. There's 5 different columns that show how many trips each month went with which specific base. I stuck with the same variation of how to show different graphs like this because I feel like it is the easiest way to compare all of the data at once. "
text8 <- "Every heatmap I created I used geom_tile. The first heatmap shows trips per hour by day. The later hours have the highest heatmap. the begginging of the map and end of the heatmap seem to flip. "
text9 <- "The second heatmap I created shows the amount of trips per day by month. This data is scattered a lot more than hour by day. "
text10 <- "The third heatmap I created shows the amount of trips per month by weeks. This heatmap looks a lot different then the rest. There are a lot of empty areas compared to the other heatmaps. The later months is the busiest. "
text11 <- "The fourth heatmap I created shows the trips comapred to the base by day of the week. The first and the last bases are much lower comapred to the bases in the middle. "
text12 <- "I created a leaflet that shows only 2000 of the lat and lons. The reason for this is because everytime I ran the whole code R would crash. All of the points are on the east side of the US"




ui<-fluidPage( 
  
  tabsetPanel(
    
    tabPanel("table",
             fluidRow(
               column(2.5, textOutput("text_output1")),
               column(3.5,DT::dataTableOutput("table", width = "100%")))),
    
    tabPanel("plot1",
             fluidRow(
               column(7, textOutput("text_output2")),
               column(8,plotOutput('plot_01', width = '1000px')))),
    
    tabPanel("plot2",
             fluidRow(column(12, textOutput("text_output3")),
                      column(12,plotOutput('plot_02', width = '1000px')))),
    
    tabPanel("plot3",
             fluidRow(column(12, textOutput("text_output4")),
                      column(12,plotOutput('plot_03', width = '1000px')))),
    
    tabPanel("plot4-9",
             fluidRow(column(12, textOutput("text_output5")),
                      column(12,plotOutput('plot_04', width = '1000px')),
                      column(12,plotOutput('plot_05', width = '1000px')),
                      column(12,plotOutput('plot_06', width = '1000px')), 
                      column(12,plotOutput('plot_07', width = '1000px')), 
                      column(12,plotOutput('plot_08', width = '1000px')),
                      column(12,plotOutput('plot_09', width = '1000px')))), 
    
    
    tabPanel("table2",
             fluidRow(
               column(12, textOutput("text_output6")),
               column(12,DT::dataTableOutput("table2", width = "100%")))),
    
    tabPanel("plot10",
             fluidRow(column(12, textOutput("text_output7")),
                      column(12,plotOutput('plot_10', width = '1000px')))), 
    
    tabPanel("heatmap1", 
             fluidRow(column(12, textOutput("text_output8")),
                      column(12,plotOutput('heatmap_1', width = '1000px')))),
    
    tabPanel("Heatmap2",
             fluidRow(column(12, textOutput("text_output9")),
                      column(12,plotOutput('heatmap_2', width = '1000px')))),
    
    tabPanel("heatmap3", 
             fluidRow(column(12, textOutput("text_output10")),
                      column(12,plotOutput('heatmap_3', width = '1000px')))),
    
    tabPanel("heatmap4",
             fluidRow(column(12, textOutput("text_output11")),
                      column(12,plotOutput('heatmap_4', width = '1000px')))),
    
    tabPanel("Leaflet",
             fluidRow(column(12, textOutput("text_output12")),
                      column(12, leafletOutput("leaf")))),
    
    tabPanel("model", 
             fluidRow(
               #column(12, textOutput("text_output13")),
               column(12, plotOutput("model1"))))
    
    
    
  )
)

server<-function(input,output){
  
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
  
  output$text_output3 <- renderText({ text3 })
  
  output$plot_02 <- renderPlot({
    ggplot(trips_by_hour, aes(x = hour, y = trips)) +
      geom_col(fill = "steelblue") +
      xlab("hour") +
      ylab("trips") +
      ggtitle("trips by the hour")
    
  })
  
  output$text_output4 <- renderText({ text4 })
  
  output$plot_03 <- renderPlot({
    ggplot(trips_by_day_month, aes(x = day_of_week, y = trips, fill = month)) +
      geom_col() +
      xlab("day_of_week") +
      ylab("month") +
      ggtitle("trips by the the day by the month")
  })
  
  output$text_output5 <- renderText({ text5 })
  
  output$plot_04 <- renderPlot({
    ggplot(filter(trips_by_full_month, month == "May"), aes(x = day , y = trips)) +
      geom_col(fill = "blue") +
      xlab("day") +
      ylab("trips") +
      ggtitle("trips in May")
  })
  
  output$plot_05 <- renderPlot({
    ggplot(filter(trips_by_full_month, month == "Apr"), aes(x = day , y = trips)) +
      geom_col(fill = "purple") +
      xlab("day") +
      ylab("trips") +
      ggtitle("trips in April")
  })
  
  output$plot_06 <- renderPlot({
    ggplot(filter(trips_by_full_month, month == "Jun"), aes(x = day , y = trips)) +
      geom_col(fill = "red") +
      xlab("day") +
      ylab("trips") +
      ggtitle("trips in June")
  })
  
  output$plot_07 <- renderPlot({
    ggplot(filter(trips_by_full_month, month == "Jul"), aes(x = day , y = trips)) +
      geom_col(fill = "green") +
      xlab("day") +
      ylab("trips") +
      ggtitle("trips in July")
  })
  
  output$plot_08 <- renderPlot({
    ggplot(filter(trips_by_full_month, month == "Aug"), aes(x = day , y = trips)) +
      geom_col(fill = "skyblue") +
      xlab("day") +
      ylab("trips") +
      ggtitle("trips in August")
  })
  
  output$plot_09 <- renderPlot({
    ggplot(filter(trips_by_full_month, month == "Sep"), aes(x = day , y = trips)) +
      geom_col(fill = "salmon") +
      xlab("day") +
      ylab("trips") +
      ggtitle("trips in September")
  })
  
  output$text_output6 <- renderText({ text6 })
  
  output$table2 <- DT::renderDataTable(trips_by_full_month[,c("day","trips", "month")],options = list(pageLength = 4)) 
  
  output$text_output7 <- renderText({ text7 })
  
  output$plot_10 <- renderPlot({
    ggplot(trips_by_base_month, aes(x = base , y = trips, fill = month)) +
      geom_col() +
      xlab("base") +
      ylab("trips") +
      ggtitle("base per month")
    
  }) 
  
  output$text_output8 <- renderText({ text8 })
  
  output$heatmap_1 <-renderPlot({
    ggplot(trips_by_hour_day, aes(x = hour, y = day, fill = trips)) +
      geom_tile() + 
      xlab("hour") + 
      ylab("day")  
  })
  
  output$text_output9 <- renderText({ text9 })
  
  output$heatmap_2 <- renderPlot({
    ggplot(trips_by_full_month, aes(x = month, y = day, fill = trips)) + 
      geom_tile() + 
      xlab("month") + 
      ylab("day")
  }) 
  
  output$text_output10 <- renderText({ text10 })
  
  output$heatmap_3 <- renderPlot({
    ggplot(trips_by_month_week, aes(x = month, y = week, fill = trips)) +
      geom_tile() + 
      xlab("month") +
      ylab("week")
  })
  
  output$text_output11 <- renderText({ text11 })
  
  output$heatmap_4 <- renderPlot({
    ggplot(trips_by_base_day, aes(x = base, y = day_of_week, fill = trips)) +
      geom_tile() + 
      xlab("base") +
      ylab("day")
  })
  
  output$text_output12 <- renderText({ text12 })
  
  output$leaf <- renderLeaflet({
    leaflet(head(trips_by_lat_lon, 2000)) %>%
      addTiles() %>%
      addMarkers(~lon, ~lat, popup = "trips")
  })
  
  output$text_output13 <- renderText({ text13 })
  
  output$model1 <- renderPlot({
    model <- lm(trips ~ month, data = trips_by_full_month)
    predictions <- predict(model)
    observed <- trips_by_full_month$trips
    plot(predictions, observed, xlab = "Predicted", ylab = "Observed")
  })
} 




shinyApp(ui=ui, server=server)









