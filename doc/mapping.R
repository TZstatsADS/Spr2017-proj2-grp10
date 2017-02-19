finaldata <- read.csv("~/scr/ADS-Spring2017/Spr2017-proj2-grp10/data/finaldata.csv")
library(leaflet)
library(maps)
library(htmltools)
mapStates = map("state", fill = TRUE, plot = FALSE)
leaflet(data = mapStates) %>% addTiles() %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE) %>%
  addMarkers(finaldata$Longitude, finaldata$Latitude, 
             popup = content)
content <- paste(sep = "<br/>",
                 as.character(finaldata$Name),
                 paste("Rank:", as.character(finaldata$Rank))
)

urls <- finaldata$
"<b><a href='http://www.samurainoodle.com'>Samurai Noodle</a></b>"


text_popup <- paste(finaldata$Name, 
                    "Rank:", 
                    as.character(finaldata$Rank))

#_______________________________________________________________

df <- read.csv(textConnection(
  "Name,Lat,Long
  Samurai Noodle,47.597131,-122.327298
  Kukai Ramen,47.6154,-122.327157
  Tsukushinbo,47.59987,-122.326726"
))

leaflet(df) %>% addTiles() %>%
  addMarkers(~Long, ~Lat, popup = ~htmlEscape(Name))
#_________________________________________________________________


content <- paste(sep = "<br/>",
                 "<b><a href='http://www.samurainoodle.com'>Samurai Noodle</a></b>",
                 "606 5th Ave. S",
                 "Seattle, WA 98138"
)
leaflet() %>% addTiles() %>%
  addPopups(-122.327298, 47.597131, content,
            options = popupOptions(closeButton = FALSE)
)


addPopups(-122.16883, 37.42697, content,options = popupOptions(closeButton =T))
