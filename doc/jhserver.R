
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
  schdata<- read.csv("~/Desktop/Spr2017-proj2-proj2_team10/data/final3data.csv")
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
})