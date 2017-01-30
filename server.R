#library used
library(ggmap)
library(ggplot2)
library(shiny)
#library(ggiraph)

#getting data file
trolley1 <- read.csv(file = "https://s3-ap-southeast-1.amazonaws.com/trolleyproject/trolleyrawfeeds.csv", header = TRUE, sep = ",")

#shiny server for display map
shinyServer(function(input, output, session) {
  
  output$NTUCmap <- renderPlot({
    #get map from google

    dotsize <- c(1,2,3,4,5,6,7) 
    
    Data1 <- trolley1[trolley1$HR == input$hour,]
      
    #trolleyColor <- c("blue","red")
    #names(trolleyColor) <- c("H","M")

    sing <- get_map(location = c(lon = input$panX, lat = input$panY), color = "color", zoom = input$zoom, maptype = "hybrid", source = "google")

      s <- ggmap(sing) + geom_point(
      data = Data1, 
      aes(x = Longtitude, y = Latitude,colour = Location),
      #colour = trolleyColor[Data1$Msg],
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