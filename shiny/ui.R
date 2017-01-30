library(ggmap)
library(ggplot2)
library(shiny)

shinyUI(fluidPage(
  titlePanel("NTUC Fairprice Extra map with trolley location data"),
  
  sidebarLayout(
    sidebarPanel(
      helpText(h4("Trolley Location")),
      sliderInput("Zoom",
                  "Zoom value: ",
                  min = 6, max = 18,
                  value = 17,
      )
    ),
    
    mainPanel(
      plotOutput("NTUCmap")
    )
  )
))
