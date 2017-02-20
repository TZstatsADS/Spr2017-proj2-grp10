shinyServer(function(input,output){
  #read data
  schdata<- read.csv("final3data.csv")
  #subset data depending on user input in Shiny app
  schinput<-reactive({
    {if (input$major == "NA") {
      v1<-schdata
    }
    else {
      selectmaj<-paste("Major", "_", input$major, sep="")
      v1<- schdata %>% filter_(paste(selectmaj, "==", 1))
    }}
      
    {if (input$city == "NA") {
      v2<- v1} 
    else {
      v2<- filter(v1, Citytype %in% input$city)
    }} 
    
    {if (input$schooltype == "NA") {
      v3<-v2
    }  
    else {
      v3<- filter(v2, Ownership %in% input$schooltype)
    }}
  
  })
  
})
