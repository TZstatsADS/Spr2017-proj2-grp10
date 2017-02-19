finaldata <- read.csv("~/scr/ADS-Spring2017/Spr2017-proj2-grp10/data/finaldata.csv")
library(leaflet)
library(maps)
library(htmltools)

# Content that shows up on pop-up window
urls <- paste0(as.character("<b><a href='http://"), as.character(finaldata$URL), "'>", as.character(finaldata$Name),as.character("</a></b>"))
content <- paste(sep = "<br/>",
                 urls, 
                 paste("Rank:", as.character(finaldata$Rank))
)

mapStates = map("state", fill = TRUE, plot = FALSE)
leaflet(data = mapStates) %>% addTiles() %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE) %>%
  addMarkers(finaldata$Longitude, finaldata$Latitude, 
             popup = content)


