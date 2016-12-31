library(shiny)
library(ggplot2)
library(reshape2)
library(dplyr)

life <- read.csv("./data/lifeExp.csv")
life <- life[,-c(2:4,60:61)]
life <- life[-which(rowSums(is.na(life))==55),]

shinyServer(function(input, output) {
    
    dataInput <- reactive({
        select1 <- ifelse(input$country1=="NONE", NA, input$country1)
        select2 <- ifelse(input$country2=="NONE", NA, input$country2)
        selected <- c(select1, select2)
        
        data <- life %>% filter(Country.Name %in% selected)
        mdata <- melt(data, id.vars=1, measure.vars=2:56, value.name='LifeExp')
        mdata$Year <- rep(1960:2014, each=2-sum(is.na(selected)))
        mdata <- mdata[complete.cases(mdata), c(1,3,4)]
        mdata$Country.Name <- factor(mdata$Country.Name, levels=selected)
        mdata <- arrange(mdata, Country.Name)
        
        m1 <- mdata %>% filter(Country.Name==select1)
        m2 <- mdata %>% filter(Country.Name==select2)
        mm1 <- m1[c(which.min(m1$Year),which.max(m1$Year)),]
        mm2 <- m2[c(which.min(m2$Year),which.max(m2$Year)),]
        minMaxLE <- rbind(mm1,mm2)
        if(any(m1$LifeExp < min(mm1$LifeExp, na.rm=T))){
            extra <- m1[which.min(m1$LifeExp),]
            minMaxLE <- rbind(minMaxLE,extra)
        }
        if(any(m1$LifeExp > max(mm1$LifeExp, na.rm=T))){
            extra <- m1[which.max(m1$LifeExp),]
            minMaxLE <- rbind(minMaxLE,extra)
        }
        if(any(m2$LifeExp < min(mm2$LifeExp, na.rm=T))){
            extra <- m2[which.min(m2$LifeExp),]
            minMaxLE <- rbind(minMaxLE,extra)
        }
        if(any(m2$LifeExp > max(mm2$LifeExp, na.rm=T))){
            extra <- m2[which.max(m2$LifeExp),]
            minMaxLE <- rbind(minMaxLE,extra)
        }
        minMaxLE <- arrange(minMaxLE, Country.Name, Year)
        list(mdata, minMaxLE)
    })
    output$plot1 <- renderPlot({
        if(input$worldAvg){
            avg <- colMeans(life[,-1], na.rm = TRUE)
            avg <- cbind.data.frame(Country.Name="World", t(avg))
            meltAvg <- melt(avg, id.vars=1, measure.vars=2:56, value.name = 'LifeExp')
            meltAvg$Year <- 1960:2014
        }
         
        g <- ggplot(dataInput()[[1]], aes(x=Year, y=LifeExp, color=Country.Name))+
            geom_line(lwd=2, alpha=0.7)+
            ylim(19,84)+
            scale_color_manual(name = "Country / Region:",
                               values=c("dodgerblue3", "indianred3"))+
            {if(input$minMax)geom_point(aes(x=Year, y=LifeExp, color=Country.Name),
                                        data=dataInput()[[2]], size=5)}+
            {if(input$worldAvg)geom_line(aes(x=Year, y=LifeExp),data=meltAvg, 
                                         color="palegreen3", lwd=1, lty=5, alpha=0.5)}+
            theme_minimal()+
            labs(y="Life Expectancy")+
            theme(legend.position='top', axis.text = element_text(size=18),
                  axis.title = element_text(size=18, color='gray20'),
                  legend.text = element_text(size=14, color='gray20'),
                  legend.title = element_text(size=14, face='bold', color='gray20'))
        g
    })
    
    output$names <- renderText({
        paste0("Change in ", 
               ifelse(input$country1=="NONE", "", input$country1),
               ifelse(input$country1!="NONE" & input$country2!="NONE", ", ", ""),
               ifelse(input$country2=="NONE", "", input$country2),
               " Life Expectancy (1960-2014)")
    })
    
    output$data <- renderTable({
        tdata <- dataInput()[[2]]
        names(tdata) <- c("Country Name", "Life Exp.", "Year")
        tdata
    })
    
    output$stats <- renderTable({
        tdata <- dataInput()[[2]]
        c1 <- input$country1
        c2 <- input$country2
        t1 <- filter(tdata, Country.Name==c1)
        t2 <- filter(tdata, Country.Name==c2)
        change <- round(c(t1[nrow(t1),2]-t1[1,2], t2[nrow(t2),2]-t2[1,2]),2)
        average <- dataInput()[[1]] %>% group_by(Country.Name) %>% summarise(Average=mean(LifeExp))
        average$`Overall Change` <- change
        names(average)[1] <- "Country Name"
        average
    })
})
