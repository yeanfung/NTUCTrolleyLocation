#library used
library(ggmap)
library(ggplot2)
library(shiny)
library(ggiraph)

#getting data file
Data1 <- read.csv(file = "https://s3-ap-southeast-1.amazonaws.com/trolleyproject/trolleyrawfeeds.csv", header = TRUE, sep = ",")

#shiny server for display map
shinyServer(function(input, output, session) {
  
  output$NTUCmap <- renderPlot({
    #get map from google

    dotsize <- c(1,2,3,4,5,6,7) 
    
    sing <- get_map(location = c(lon = 103.704933, lat = 1.339686), color = "color", zoom = input$zoom, maptype = "hybrid", source = "google")

      s <- ggmap(sing) + geom_point(
      data = Data1, 
      aes(x = Longtitude, y = Latitude, tooltip = as.character(Sensor.ID)),
      colour = "red",
      size = dotsize[input$zoom-11],
      alpha = 1.0
    )
    
    #ggiraph(code = {print(s)}, zoom_max = 5,
    #        tooltip_offx = 20, tooltip_offy = -10, 
    #        hover_css = "fill:black;",
    #        tooltip_opacity = 0.7)
    
    print(s)
  })
  
})