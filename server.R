#library used
library(ggmap)
library(ggplot2)
library(shiny)

#getting data file
trolley1 <- read.csv(file = "http://s3-ap-southeast-1.amazonaws.com/trolleyproject/trolleyrawfeeds.csv", header = TRUE, sep = ",")

#shiny server for display map
shinyServer(function(input, output, session) {
  
  output$NTUCmap <- renderPlot({
    #get map from google

    dotsize <- c(1,2,3,4,5,6,7) 
    
    Data1 <- trolley1[trolley1$HR == input$hour,]
    Data1Summary <- data.frame(table(Data1$Latitude,Data1$Longtitude,Data1$Location))
    Data1Summary <- Data1Summary[Data1Summary$Freq > 0,]
    names(Data1Summary) <- c("Latitude","Longtitude","Location","TotalNo")
    Data1Summary$Latitude <- as.numeric(as.character.factor(Data1Summary$Latitude))
    Data1Summary$Longtitude <- as.numeric(as.character.factor(Data1Summary$Longtitude))
    Data1Summary$TotalNo <- as.factor(Data1Summary$TotalNo)
    
    sing <- get_map(location = c(lon = input$panX, lat = input$panY), color = "color", zoom = input$zoom, maptype = "hybrid", source = "google")

      s <- ggmap(sing) + geom_point(
      data = Data1Summary, 
      aes(x = Longtitude, y = Latitude,colour = Location, shape=TotalNo),
      size = dotsize[input$zoom-11],
      alpha = 0.8
    )

    print(s)
  })
  
})