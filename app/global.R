# Load required libraries
packages.used=c("dplyr", "data.table","readr","shiny", "plotly", "shinydashboard", "leaflet",
                "scales", "lattice", "htmltools", "maps", "dtplyr"
                )
packages.needed=setdiff(packages.used, 
                        intersect(installed.packages()[,1], 
                                  packages.used))
if(length(packages.needed)>0){
  install.packages(packages.needed, dependencies = TRUE,
                   repos='http://cran.us.r-project.org')
}


library(dplyr)
library(data.table)
library(readr)
library(shiny)
library(plotly)
library(leaflet)
library(shinydashboard)
library(scales)
library(lattice)
library(htmltools)
library(maps)
library(dtplyr)
