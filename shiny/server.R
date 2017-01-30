#library used
library(ggmap)
library(ggplot2)
library(shiny)

#getting data file
setwd("D:/R/Working Directory/shiny")
list.files()
Data1 <- read.csv(file = "NTUC_Trolley_Location.csv", header = TRUE, sep = ",")

#BMIframe <- as.data.frame(BMI)

#BMIframe$alpha <- ifelse (BMIframe$BMI >= 10 & BMIframe$BMI < 30, 0.5, 1)

#shiny server for display map
shinyServer(function(input, output) {
  
  
  output$NTUCmap <- renderPlot({
    #get map from google
    zoomvalue <- reactive(input$Zoomvalue)

    if(is.null(zoomvalue())) 
       {
      zoommap = 18
    }
       else
       {
         zoommap = zoomvalue()
       }
    #print(input$Zoomvalue)
    
    sing <- get_map(location = c(lon = 103.704933, lat = 1.339686), color = "color", zoom = 17, maptype = "hybrid", source = "google")
    
    #BMIframe$value1 <- ifelse(BMIframe$BMI >= BMIvalue(), 1, 0)
                    
    #value <- sum(BMIframe$value1)
    
    #BMIframe$value2 <- ifelse(BMIframe$value1 == 1, BMIframe$BMI, 0)
    
    #dummy lat long                          
    #lat1 <- runif(value,1.307301,1.307599)
    #lat2 <- runif(value,1.307501,1.307999)
    
    #long1 <- runif(value,103.780301,103.780599)
    #long2 <- runif(value,103.779601,103.779899) 
    
    #BMIframe$lat <- ifelse (BMIframe$value2 >= 10 & BMIframe$value2 < 30, lat1, lat2)
    #lat <- BMIframe$lat
    #BMIframe$long <- ifelse (BMIframe$value2 >= 10 & BMIframe$value2 < 30, long1, long2)
    #long <- BMIframe$long
    #fix map border
    lao <- data.frame (Data1$Trolley_Latitude,Data1$Trolley_Longitude)
  
    s <- ggmap(sing) + geom_point(
      data = lao, 
      aes_string(x = "Data1$Trolley_Longitude", y = "Data1$Trolley_Latitude"),
      colour ="red", 
      size = 6,
      alpha = 1.0
    )
    print(s)
  })
})