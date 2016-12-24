#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
life <- read.csv('data/lifeExp.csv')

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Life Expectancy"),
  h3("Documentation"),
  p("here goes the documentation"),
  br(),
  hr(),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("country1", label=h4("Select Country/Region #1"), 
                   choices = life$Country.Name, selected = 'United States'),
       selectInput("country2", label=h4("Select Country/Region #2"), 
                   choices = life$Country.Name, selected = 'China')
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        h4(textOutput("names")),
        plotOutput("plot1")
    )
  )
))
