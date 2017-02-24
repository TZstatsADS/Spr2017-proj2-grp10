

navbarPage("Ourname", id = "nav", 
           tabpanel("Interactive map", 
                    div(class = "outer", 
                        leafletOutput("map", width = "100%", height = "100%"))))


#####     map server   #########
library(leaflet)
library(maps)
library(htmltools)


marker_opt <- markerOptions(opacity = 0.8, riseOnHover = T)
output$map <- renderLeaflet({
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
})











