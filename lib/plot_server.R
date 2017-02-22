#####################
library(shiny)
library(leaflet)
library(data.table)
library(ggmap)
library(dplyr)
library(plotly)
library(ggplot2)
library(geosphere)
# Density curve for Earning:
output$click_rank_plot <- renderPlotly({
  edu <- filterdata
  earn <- edu %>% select(Name, Earn) %>% arrange(desc(Earn)) 
  earn$Earn <- as.numeric(as.character(earn$Earn))
  a <- ggplot(data = earn,aes(x=Earn)) + 
    geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "#56B4E9") +
    geom_density(fill = "#CC79A7", alpha = 0.5) +
    theme(panel.background = element_rect(fill = '#ffffff')) + 
    ggtitle("Density of Earning with Histogram overlay")
  ggplotly(a)
})

# Density curve for admission rate
output$click_Adm_rank <- renderPlotly({
  adm <- edu %>% select(Name, ADMrate)
  adm$ADMrate <- as.numeric(as.character(adm$ADMrate))
  b <- ggplot(data = adm,aes(x=ADMrate)) + 
    geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "#56B4E9") +
    geom_density(fill = "#CC79A7", alpha = 0.5) +
    theme(panel.background = element_rect(fill = '#ffffff')) + 
    ggtitle("Density of Admission Rate with Histogram overlay")
  ggplotly(b)
}) 

# Density curve for Average cost
output$click_Cost_rank <- renderPlotly({
  fee <- edu %>% select(Name, AvgCost)
  c <- ggplot(data = fee,aes(x=AvgCost)) + 
    geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "#56B4E9") +
    geom_density(fill = "#CC79A7", alpha = 0.5) +
    theme(panel.background = element_rect(fill = '#ffffff')) + 
    ggtitle("Density of Average Cost with Histogram overlay")
  ggplotly(c)
})  

# Density curve for SAT score
output$click_SAT_rank <- renderPlotly({
  sat <- edu %>% select(Name, SAT)
  sat$SAT <- as.numeric(as.character(sat$SAT))
  d <- ggplot(data = sat,aes(x=SAT)) + 
    geom_histogram(aes(y = ..density..), alpha = 0.7, fill = "#56B4E9") +
    geom_density(fill = "#CC79A7", alpha = 0.5) +
    theme(panel.background = element_rect(fill = '#ffffff')) + 
    ggtitle("Density of Average SAT Score with Histogram overlay")
  ggplotly(d)
})