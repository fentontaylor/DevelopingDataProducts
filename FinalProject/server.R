library(shiny)
library(ggplot2)
library(reshape2)
library(dplyr)

life <- read.csv("./data/lifeExp.csv")
life <- life[,-c(2:4,60:61)]
life <- life[-which(rowSums(is.na(life))==55),]

shinyServer(function(input, output) {
    
    output$plot1 <- renderPlot({
        select1 <- ifelse(input$country1=="NONE", NA, input$country1)
        select2 <- ifelse(input$country2=="NONE", NA, input$country2)
        selected <- c(select1, select2)
        
        data <- life[life$Country.Name %in% selected, ]
        mdata <- melt(data, id.vars=1, measure.vars=2:56, value.name='LifeExp')
        mdata$Year <- rep(1960:2014, each=2-sum(is.na(selected)))
        mdata$Country.Name <- factor(mdata$Country.Name, levels=selected)
        
        ###This part needs to be fixed to get the min and max for each country
        if(input$minMax){
            m1 <- mdata %>% filter(Country.Name==select1)
            m2 <- mdata %>% filter(Country.Name==select2)
            mm1 <- m1[c(which.min(m1$Year),which.max(m1$Year)),c(1,3,4)]
            mm2 <- m2[c(which.min(m2$Year),which.max(m2$Year)),c(1,3,4)]
            minMaxLE <- rbind(mm1,mm2)
            if(any(m1$LifeExp < min(mm1$LifeExp))){
                extra <- m1[which.min(m1$LifeExp),c(1,3,4)]
                minMaxLE <- rbind(minMaxLE,extra)
            }
            if(any(m1$LifeExp > max(mm1$LifeExp))){
                extra <- m1[which.max(m1$LifeExp),c(1,3,4)]
                minMaxLE <- rbind(minMaxLE,extra)
            }
            if(any(m2$LifeExp < min(mm2$LifeExp))){
                extra <- m2[which.min(m2$LifeExp),c(1,3,4)]
                minMaxLE <- rbind(minMaxLE,extra)
            }
            if(any(m2$LifeExp > max(mm2$LifeExp))){
                extra <- m2[which.max(m2$LifeExp),c(1,3,4)]
                minMaxLE <- rbind(minMaxLE,extra)
            }
            
        }
        
        if(input$worldAvg){
            avg <- colMeans(life[,-1], na.rm = TRUE)
            avg <- cbind.data.frame(Country.Name="World", t(avg))
            meltAvg <- melt(avg, id.vars=1, measure.vars=2:56, value.name = 'LifeExp')
            meltAvg$Year <- 1960:2014
        }
      
        g <- ggplot(mdata, aes(x=Year, y=LifeExp, color=Country.Name))+
            geom_line(lwd=2, alpha=0.7)+
            scale_color_manual(values=c("dodgerblue3", "indianred3"))+
            {if(input$minMax)geom_point(aes(x=Year, y=LifeExp, color=Country.Name),
                                        data=minMaxLE, size=5)}+
            {if(input$worldAvg)geom_line(aes(x=Year, y=LifeExp),data=meltAvg, 
                                         color="palegreen3", lwd=1, lty=5, alpha=0.5)}+
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
