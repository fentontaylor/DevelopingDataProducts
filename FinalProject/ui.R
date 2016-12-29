library(shiny)
life <- read.csv('data/lifeExp.csv')
life <- life[,-c(2:4,60:61)]
life <- life[-which(rowSums(is.na(life))==55),]
cnames <- c(as.character(life$Country.Name),"NONE")

shinyUI(fluidPage(
  
  titlePanel("Life Expectancy"),
  h3("Documentation"),
  p("here goes the documentation"),
  br(),
  hr(),
  
  sidebarLayout(
    sidebarPanel(
       selectInput("country1", label=h4("Select Country/Region #1"), 
                   choices = cnames, selected = 'United States'),
       selectInput("country2", label=h4("Select Country/Region #2"), 
                   choices = cnames, selected = 'NONE'),
       checkboxInput("minMax", label="Show Min/Max Points", value=TRUE),
       checkboxInput("worldAvg", label="Show World Average", value=TRUE)
    ),
    
    mainPanel(
        h4(textOutput("names")),
        plotOutput("plot1"),
        br(),
        hr(),
        tableOutput("data")
    )
  )
))
