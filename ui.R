#library(ggmap)
#library(ggplot2)
library(shiny)

shinyUI(fluidPage(
  
  titlePanel("NTUC Fairprice Extra Jurong Point Trolley Location"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("zoom", label = "Zoom",
                  min = 12, max = 18, value = 15, step = 1),
      sliderInput("panX", label = "X",
                  min = 103.69, max = 103.72, value = 103.704933, step = 0.000001),
      sliderInput("panY", label = "Y",
                  min = 1.32, max = 1.36, value = 1.339686, step = 0.000001),
      sliderInput("hour", label = "Hour",
                  min = 0, max = 23, value = 23, step = 1)
      ),
    mainPanel(
      plotOutput("NTUCmap")
    )
  )
))
