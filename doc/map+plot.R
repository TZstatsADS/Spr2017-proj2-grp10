
library(shiny)
library(leaflet)
library(scales)
library(lattice)
library(dplyr)
library(htmltools)
library(maps)
library(plotly)


function(input,output,session){
# Create map
output$map <- renderLeaflet({
  leaflet() %>%
    addTiles(
      urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
      attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
    ) %>%
    setView(lng = -93.85, lat = 37.45, zoom = 4)
})


# Data cleaning
final1data<-read.csv("~/Desktop/final2data.csv",na = "null")
final2data <- read.csv("~/Desktop/final3data.csv",na = "null")

final2data$citytype<-final1data$Citytype

final3data<-final2data %>%
  mutate(ADMrate=ifelse(ADMrate=="NULL", NA,as.numeric(ADMrate))) %>%
  mutate(Earn=ifelse(Earn=="PrivacySuppressed", NA,as.numeric(Earn))) %>%
  mutate(AvgCost=as.numeric(AvgCost)) %>%
  mutate(CrimeRate=as.numeric(as.character(CrimeRate))) %>%
  mutate(HappyScore=as.numeric(as.character(HappyScore))) 

TEST<-final3data %>%
  mutate(Pcrime=CrimeRate/max(CrimeRate)) %>%
  mutate(Phappy=HappyScore/max(HappyScore)) %>%
  mutate(Pcity=citytype/max(citytype))

# A reactive expression that returns the set of zips that are in bounds right now
collegeInBounds <- reactive({
  if (is.null(input$map_bounds))
    return(TEST[FALSE,])
  bounds <- input$map_bounds
  latRng <- range(bounds$north, bounds$south)
  lngRng <- range(bounds$east, bounds$west)
  
  subset(TEST,
         Latitude >= latRng[1] & Latitude <= latRng[2] &
           Longitude >= lngRng[1] & Longitude <= lngRng[2])
})


# Plot density
output$density <- renderPlot({
  # If no college are in view, don't plot
  if (nrow(collegeInBounds()) == 0)
    return(NULL)
  
  # Density curve for Earning:
  earn <- collegeInBounds() %>% 
    select(Name, Earn) %>% 
    arrange(desc(Earn)) 
  earn$Earn <- as.numeric(as.character(earn$Earn))
  a <- ggplot(data = earn,aes(x=Earn)) + 
    geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "#56B4E9") +
    geom_density(fill = "#CC79A7", alpha = 0.5) +
    theme(panel.background = element_rect(fill = '#ffffff')) + 
    ggtitle("Density of Earning with Histogram overlay")
  ggplotly(a)
  
  # Density curve for admission rate
  adm <- collegeInBounds() %>% select(Name, ADMrate)
  adm$ADMrate <- as.numeric(as.character(adm$ADMrate))
  b <- ggplot(data = adm,aes(x=ADMrate)) + 
    geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "#56B4E9") +
    geom_density(fill = "#CC79A7", alpha = 0.5) +
    theme(panel.background = element_rect(fill = '#ffffff')) + 
    ggtitle("Density of Admission Rate with Histogram overlay")
  ggplotly(b)
  
  # Density curve for Average cost
  fee <- collegeInBounds() %>% select(Name, AvgCost)
  c <- ggplot(data = fee,aes(x=AvgCost)) + 
    geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "#56B4E9") +
    geom_density(fill = "#CC79A7", alpha = 0.5) +
    theme(panel.background = element_rect(fill = '#ffffff')) + 
    ggtitle("Density of Average Cost with Histogram overlay")
  ggplotly(c)
  
  # Density curve for SAT score
  sat <- collegeInBounds() %>% select(Name, SAT)
  sat$SAT <- as.numeric(as.character(sat$SAT))
  d <- ggplot(data = sat,aes(x=SAT)) + 
    geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "#56B4E9") +
    geom_density(fill = "#CC79A7", alpha = 0.5) +
    theme(panel.background = element_rect(fill = '#ffffff')) + 
    ggtitle("Density of Average SAT Score with Histogram overlay")
  ggplotly(d)  
})



# Plot barplot

output$barplot <- renderPlot({
if (nrow(collegeInBounds()) == 0)
  return(NULL)

word<-c("Happy","Crime","City") 
real<-c(collegeInBounds()$Phappy,collegeInBounds()$Pcrime,collegeInBounds()$Pcity)
compare<-c(1-collegeInBounds()$Phappy,1-collegeInBounds$Pcrime,1-collegeInBounds()$Pcity)
data<-data.frame(word,real,compare)
plot_ly(data,x=~word,y=~real,type = "bar") %>%
  add_trace(y=~compare)%>%
  layout(yaxis=list(title=""),xaxis=list(title=""),barmode="stack")
})

# Show a pop-up at the given location
showcollegePopup <- function(zipcode, lat, lng) {
  selectedZip <- TEST[TEST$zipcode == zipcode,]
  urls <- paste0(as.character("<b><a href='http://"), as.character(finaldata$URL), "'>", as.character(finaldata$Name),as.character("</a></b>"))
  content <- paste(sep = "<br/>",
                   urls, 
                   paste("Rank:", as.character(finaldata$Rank))
  )
  leafletProxy("map") %>% addPopups(lng, lat, content, layerId = zipcode)
}


# When map is clicked, show a popup with city info
observe({
  leafletProxy("map") %>% clearPopups()
  event <- input$map_shape_click
  if (is.null(event))
    return()
  
  isolate({
    showZipcodePopup(event$id, event$lat, event$lng)
  })
})
}


