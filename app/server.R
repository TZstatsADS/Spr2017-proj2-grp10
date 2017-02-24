packages.used=c("dplyr", "plotly", "shiny", "leaflet", "scales", 
                "lattice", "htmltools", "maps", "data.table", 
                "dtplyr")

# check packages that need to be installed.
packages.needed=setdiff(packages.used, 
                        intersect(installed.packages()[,1], 
                                  packages.used))
# install additional packages
if(length(packages.needed)>0){
  install.packages(packages.needed, dependencies = TRUE)
}


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
    final1dat[,c(3,4,2, 10, 13,14,27,28, 29)]
  },options = list(orderClasses = TRUE))
  
  
  output$tablerank2 <- renderDataTable({
    data<-v3()
    w1<-input$Earn
    w2<-input$rank
    w3<-input$AvgCost
    w4<-input$CrimeRate
    w5<-input$HappyRank
    final2dat<-data %>%
      select(Name,Earn, ADMrate,QSRank,AvgCost,CrimeRate,HappyRank, State, SAT)%>%
      arrange(Earn,QSRank)%>%
      mutate(Earn1=seq(1:nrow(data)))%>%
      arrange(AvgCost,QSRank)%>%
      mutate(AvgCost1=seq(1:nrow(data)))%>%
      arrange(CrimeRate,QSRank)%>%
      mutate(CrimeRate1=seq(1:nrow(data)))%>%
      arrange(HappyRank,QSRank)%>%
      mutate(HappyRank1=seq(1:nrow(data))) %>%
      mutate(new_rank=w1*Earn1+ w2*QSRank+w3*AvgCost1+w4*CrimeRate1+w5*HappyRank1) %>%
      arrange(new_rank)
    final2dat[,c(4,1,8, 3, 9, 5, 2, 6,7)]
  },options = list(orderClasses = TRUE))
  
  
  output$map <- renderLeaflet({
    urls <- paste0(as.character("<b><a href='http://"), as.character(v3()$URL), "'>", as.character(v3()$Name),as.character("</a></b>"))
    content <- paste(sep = "<br/>",
                     urls, 
                     paste("Rank:", as.character(v3()$QSRank))
    )
    
    mapStates = map("state", fill = TRUE, plot = FALSE)
    leaflet(data = mapStates) %>% addTiles() %>%
      addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE) %>%
      addMarkers(v3()$Longitude, v3()$Latitude, 
                 popup = content)
  })
  
  output$ADMchart <- renderPlotly({
    edu <- v3()
    adm <- edu %>% select(Name, ADMrate)
    adm$ADMrate <- as.numeric(as.character(adm$ADMrate))
    b <- ggplot(data = adm,aes(x=ADMrate)) + 
      geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "#56B4E9") +
      geom_density(fill = "#CC79A7", alpha = 0.5) +
      theme(panel.background = element_rect(fill = '#ffffff')) + 
      ggtitle("Density of Admission Rate with Histogram overlay")
    ggplotly(b)
    
  }
  
  )
  
  output$cost <- renderPlotly({
    edu <- v3()
    fee <- edu %>% select(Name, AvgCost)
    fee$AvgCost <- as.numeric(as.character(fee$AvgCost))
    c <- ggplot(data = fee,aes(x=AvgCost)) + 
      geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "#56B4E9") +
      geom_density(fill = "#CC79A7", alpha = 0.5) +
      theme(panel.background = element_rect(fill = '#ffffff')) + 
      ggtitle("Density of Average Cost with Histogram overlay")
    ggplotly(c)
  }
  )
  
  output$earnchart <- renderPlotly({
    edu <- v3()
    earn <- edu %>% select(Name, Earn) %>% arrange(desc(Earn)) 
    earn$Earn <- as.numeric(as.character(earn$Earn))
    a <- ggplot(data = earn,aes(x=Earn)) + 
      geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "#56B4E9") +
      geom_density(fill = "#CC79A7", alpha = 0.5) +
      theme(panel.background = element_rect(fill = '#ffffff')) + 
      ggtitle("Density of Earnings with Histogram overlay")
    ggplotly(a)
  }
  )
output$text0<- renderText({"Choose the following:"})
output$explain1<- renderText({"Brief introduction of this app: This application aims to help users to discover and compare schools in a more efficient manner."})
output$explain2<- renderText({"1. Choose the first 3 options to do some basic filtering of schools, and obtain their rankings (based on the QS world ranking). View them on an interactive map, and also get a clearer picture of how certain relevant factors (i.e. Earnings, Cost of Attendance) of the school you are interested in fare in comparison to other schools from the density plots."})
output$explain3<- renderText({"2. If you feel like QS ranking is not your thing, feel free to utilize our slider inputs to rate how highly you value certain aspects like safety and happiness. Obtain your own personalized ranking and compare them to the QR rankings!"})  

output$text1<- renderText({"Please rate how highly you value the following:"})
  
  output$introduction<- renderText({"This application is created by Tongyue Liu, Yue Jin, Yijia Pan, Jia Hui Tan, and Qingyuan Zhang in Spring 2017. We are a group of Columbia MA Statistics students looking to make the world an easier place to live in, and we are taking a tiny step here by designing this application to help simplify the college decision making process for fellow users :)"})
  output$crimer <- renderPlotly({
    edu <- v3()
    cr <- edu %>% select(Name, CrimeRate) %>% arrange(desc(CrimeRate)) 
    cr$CrimeRate <- as.numeric(as.character(cr$CrimeRate))
    d <- ggplot(data = cr,aes(x=CrimeRate)) + 
      geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "#56B4E9") +
      geom_density(fill = "#CC79A7", alpha = 0.5) +
      theme(panel.background = element_rect(fill = '#ffffff')) + 
      ggtitle("Density of Crime Rate with Histogram overlay")
    ggplotly(d)
  }
  )
})