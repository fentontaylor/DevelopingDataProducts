library(shiny)
library(ggplot2)
library(reshape2)

life <- read.csv("./data/lifeExp.csv")
life <- life[,-c(2:4,60:61)]

shinyServer(function(input, output) {
    
    output$plot1 <- renderPlot({
        select1 <- input$country1
        select2 <- input$country2
        
        data <- life[life$Country.Name==select1 | life$Country.Name==select2, ]
        mdata <- melt(data, id.vars=1, measure.vars=2:56, value.name='LifeExp')
        mdata$Year <- rep(1960:2014, each=2)
        minLE <- mdata[which.min(mdata$LifeExp),3:4]
        maxLE <- mdata[which.max(mdata$LifeExp),3:4]
      
        g <- ggplot(mdata, aes(x=Year, y=LifeExp, color=Country.Name))+
            geom_line(lwd=2, alpha=0.7)+
            theme_minimal()+
            labs(y="Life Expectancy", 
                 title=paste0("Change in ", select1,", ",
                              select2, " Life Expectancy (1960-2014)"))
        g
    })
    
    output$names <- renderText({
        paste(input$country1, input$country2)
    })
})
