library(shiny)
life <- read.csv('data/lifeExp.csv')
life <- life[,-c(2:4,60:61)]
life <- life[-which(rowSums(is.na(life))==55),]
life$Country.Name <- as.character(life$Country.Name) 
life$Country.Name[grep("Korea, Rep", life$Country.Name)] <- "Korea, Rep. (South)"
life$Country.Name[grep("Korea, Dem", life$Country.Name)] <- "Korea, D.P.R. (North)"
life$Country.Name[grep("Cote d'Ivoire", life$Country.Name)] <- "Ivory Coast"
cnames <- c(as.character(life$Country.Name),"NONE")

shinyUI(fluidPage(
  
  titlePanel("Life Expectancy"),
  h4("The Data"),
  p("The data used in this application comes from",
    a("data.worldbank.org.", href='http://data.worldbank.org/indicator/SP.DYN.LE00.IN'),
    "The dataset contains the life expectancy estimates for 264 countries and regions 
    between the years 1960-2014. Some countries have incomplete data, but enough to 
    be included in the selection list. If a country does not appear on the list, 
    either it was not part of the original dataset, or it was removed because no 
    data were collected for that country."),
  h4("Using the App"),
  p('Select a country or region from the drop-down menus labeled "Select Country/Region."
    Selecting "NONE" will not display any output for that selection. On the left, this app displays 
    the change in life expectancy for the selected country/region over time. On the right,
    points of interest such as the first and last years of data with the corresponding life expectancy,
    as well as the minimum and maximum values for life expectancy. "Overall Change" is simply 
    the difference in the latest and earliest values of life expectancy. "Average"
    is the country/regions mean life expectancy of each year that data was collected. 
    The "Show Min/Max Points" checkbox selection shows or hides the points of interest previously mentioned.
    The "Show World Average" checkbox selection shows or hides the world average 
    life expectancy in the plot (the dashed green line).'),
  p("The R code for this app can be found on my", a("GitHub page", 
                                                    href="https://github.com/fentontaylor/DevelopingDataProducts/tree/gh-pages/FinalProject")),
  br(),
  hr(),
  fluidRow(
    column(3, offset = 1,
        selectInput("country1", label=h4("Select Country/Region #1"), 
                      choices = cnames, selected = 'United States')
    ),
    column(3, offset = 1,
        selectInput("country2", label=h4("Select Country/Region #2"),
                      choices = cnames, selected = 'NONE')
    ),
    column(3, offset = 1,
        checkboxInput("minMax", label="Show Min/Max Points", value=TRUE),
        checkboxInput("worldAvg", label="Show World Average", value=TRUE)
    )
  ),
  br(),
  hr(),
  fluidRow(
      column(6, offset = 1,
        h4(textOutput("names")),
        plotOutput("plot1")
      ),
      column(5,
        h4("Points of Interest"),
        p("(first year, latest year, minimum, maximum)"),
        tableOutput("data"),
        hr(),
        h4("Summary Statistics"),
        tableOutput("stats")
      )
  ),
  br(),
  hr()
))
  
