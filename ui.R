library(ggmap)
library(ggplot2)
library(shiny)

shinyUI(fluidPage(
  
  titlePanel("NTUC Fairprice Extra map with trolley location data"),

  sidebarLayout(
    sidebarPanel(
      helpText(h4("Trolley Location")),
      sliderInput("zoom", label = "Zoom Level",
                  min = 12, max = 18, value = 15, step = 1)
      ),
    mainPanel(
      plotOutput("NTUCmap")
    )
  )
))
