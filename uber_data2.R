library(tidyverse)
library(ggplot2)
library(dplyr)
library(shiny)
library(lubridate)


trips_by_day_month <- read.csv("trips_by_day_month.csv")
trips_by_full_month <- read.csv("trips_by_full_month.csv")
trips_by_hour <- read.csv("trips_by_hour.csv")
trips_by_hour_month <- read.csv("trips_by_hour_month.csv")
trips_by_base_month <- read.csv("trips_by_base_month.csv")
trips_by_base_day <- read.csv("trips_by_base_day.csv")
trips_by_hour_day <- read.csv("trips_by_hour_day.csv")


text1 <- "I created a table to show how many trips there are every hour. This data shows trips from hour 0-23 in the data.  "
text2 <- "I created a graph to show every trip by the hour by month. Each month shows a different color to know what data coresponds to each color. The data shows that with every month combined hour 17 is the busiest of them all"
text3 <- "I created a graph to show trips by the hour. The graph is very similar to the trips by hour and month, but I didn't include months in this graph. The graph just displays the total of trips compared to hour for every month combined. "
text4 <- "I created a graph that shows trips by the day by month. I did the same thing as the trips by hour by month and had different colors for each month to show what data goes with that month. Thursday and Fridays are pretty similar when it comes to which days are the busiest overall. "
text5 <- "The next 6 graphs show the amount of trips taken every day compared to each month. I filtered each graph to show which data went with which specific month so it would be easier to visualize how many trips there were each day. "
text6 <- "I created a table to show the amount of trips by days by month. This table can be filtered to show days in order, trips in order, and month in order. the table makes it easy to understand how the data changes every month. "
text7 <- "I created  graph to show base compared to trips. There's 5 different columns that show how many trips each month went with which specific base. I stuck with the same variation of how to show different graphs like this because I feel like it is the easiest way to compare all of the data at once. "






ui<-fluidPage( 
  
  titlePanel(title = "Uber Data"),
  
  fluidRow(
    column(2.5, textOutput("text_output1")),
    
    column(3.5,DT::dataTableOutput("table", width = "100%")),
    
    column(7, textOutput("text_output2")),
    
    column(8,plotOutput('plot_01', width = '1000px')),
    
    column(12, textOutput("text_output3")),
    
    column(12,plotOutput('plot_02', width = '1000px')),
    
    column(12, textOutput("text_output4")),
    
    column(12,plotOutput('plot_03', width = '1000px')),
    
    column(12, textOutput("text_output5")),
    
    column(12,plotOutput('plot_04', width = '1000px')),
    
    column(12,plotOutput('plot_05', width = '1000px')),
    
    column(12,plotOutput('plot_06', width = '1000px')), 
    
    column(12,plotOutput('plot_07', width = '1000px')), 
    
    column(12,plotOutput('plot_08', width = '1000px')),
    
    column(12,plotOutput('plot_09', width = '1000px')), 
    
    column(12, textOutput("text_output6")), 
    
    column(12,DT::dataTableOutput("table2", width = "100%")),
    
    column(12, textOutput("text_output7")),
    
    column(12,plotOutput('plot_10', width = '1000px')), 
    
    #column(12,plotOutput('heatmap_1', width = '1000px'))
    
    
    
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

  #output$heatmap_1 <-renderPlot({
    #heatmap(trips, xlab = 
  #})
} 



shinyApp(ui=ui, server=server)


