library(shiny)
library(ggplot2)
library(reshape2)

life <- read.csv("./data/lifeExp.csv")
life <- life[,-c(2:4,60:61)]

shinyServer(function(input, output) {
    
    output$plot1 <- renderPlot({
        select1 <- ifelse(input$country1=="NONE", NA, input$country1)
        select2 <- ifelse(input$country2=="NONE", NA, input$country2)
        selected <- c(select1, select2)
        
        data <- life[life$Country.Name %in% selected, ]
        
        mdata <- melt(data, id.vars=1, measure.vars=2:56, value.name='LifeExp')
        mdata$Year <- rep(1960:2014, each=2-sum(is.na(selected)))
        
        if(input$minMax){
            minLE <- mdata[which.min(mdata$LifeExp),3:4]
            maxLE <- mdata[which.max(mdata$LifeExp),3:4]
        }
        
        if(input$worldAvg){
            avg <- colMeans(life[,-1], na.rm = TRUE)
            avg <- cbind.data.frame(Country.Name="World", t(avg))
            meltAvg <- melt(avg, id.vars=1, measure.vars=2:56, value.name = 'LifeExp')
            meltAvg$Year <- 1960:2014
        }
      
        g <- ggplot(mdata, aes(x=Year, y=LifeExp, color=Country.Name))+
            geom_line(lwd=2, alpha=0.7)+
            {if(input$worldAvg)geom_line(aes(x=Year, y=LifeExp),data=meltAvg, 
                                         color="palegreen3", lwd=1.5, lty=2, alpha=0.5)}+
            theme_minimal()+
            labs(y="Life Expectancy", 
                 title=paste0("Change in ", 
                              ifelse(is.na(select1), "", select1),
                              ifelse(sum(is.na(selected))==0, ", ", ""),
                              ifelse(is.na(select2), "", select2),
                              " Life Expectancy (1960-2014)"))
        g
    })
    
    output$names <- renderText({
        paste(input$country1, input$country2)
    })
})
