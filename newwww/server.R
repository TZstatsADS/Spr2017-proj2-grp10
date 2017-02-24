library(shiny)
library(leaflet)
library(scales)
library(lattice)
library(dplyr)
library(htmltools)
library(maps)
library(plotly)
library(data.table)
library(dtplyr)

shinyServer(function(input, output){
  #read data
  schdata<- read.csv("final3data.csv")
  #subset data depending on user input in Shiny app
  
  major<-reactive({
    major<-input$major
  })
  
  st<-reactive({
    st<-input$schtype
  })
  
  ct<-reactive({
    ct<-input$citytype
  })
  
  v1<-reactive({
    if (major() == "None") {
      v1<-schdata
    } 
    else {
      selectmaj<-paste("Major", "_", major(), sep="")
      v1<- schdata %>% filter_(paste(selectmaj, "==", 1))}}) 
  v2<- reactive({
    if (st() == "None") {
      v2<-v1() 
    }  
    else {
      v2<- filter(v1(), Ownership==st())
    }}) 
  
  v3<- reactive({
    if (ct() == "None") {
      v3<- v2()} 
    else {
      v3<- filter(v2(), Citytype==ct()) 
    }})   
  
  output$tablerank = renderDataTable({
    final1dat<-v3()
    final1dat[,c(3,4,5,6)]
  },options = list(orderClasses = TRUE))
  
  output$tablerank2 <- renderDataTable({
    data<-v3()
    w1<-input$Earn
    w2<-input$rank
    w3<-input$AvgCost
    w4<-input$CrimeRate
    w5<-input$HappyRank
    final2dat<-data %>%
      select(Name,Earn, ADMrate,Rank,AvgCost,CrimeRate,HappyRank)%>%
      arrange(Earn,Rank)%>%
      mutate(Earn1=seq(1:nrow(data)))%>%
      arrange(AvgCost,Rank)%>%
      mutate(AvgCost1=seq(1:nrow(data)))%>%
      arrange(CrimeRate,Rank)%>%
      mutate(CrimeRate1=seq(1:nrow(data)))%>%
      arrange(HappyRank,Rank)%>%
      mutate(HappyRank1=seq(1:nrow(data))) %>%
      mutate(new_rank=w1*Earn1+ w2*Rank+w3*AvgCost1+w4*CrimeRate1+w5*HappyRank1) %>%
      arrange(new_rank)
    final2dat[,c(4,1,2,3,5)]
  },options = list(orderClasses = TRUE))
  
  makeReactiveBinding('lng')
  makeReactiveBinding('lat')
  makeReactiveBinding('Id')
  
  
  
  observe({
    event <- input$map_marker_click
    
    if (is.null(event))
      return()
    isolate({
      lat<<-event$lat
      lng<<-event$lng
      Id<<-event$id
    
    })
  })
  
  output$bchart <- renderPlotly({
    edu <- v3()
    # Density curve for Earning:
    earn <- edu %>% select(Name, Earn, Longitude, Latitude) %>% arrange(desc(Earn)) 
    earn$Earn <- as.numeric(as.character(earn$Earn))
    a <- ggplot(data = earn,aes(x=Earn)) + 
      geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "#56B4E9") +
      geom_density(fill = "#CC79A7", alpha = 0.5) +
      geom_vline(xintercept = earn[lng,]$Earn)+
      theme(panel.background = element_rect(fill = '#ffffff'))+ 
      ggtitle("Density of Earning with Histogram overlay")
    ggplotly(a)
    
  })
  
  
  
})
