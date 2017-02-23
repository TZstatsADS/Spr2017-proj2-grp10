packages.used=c("shiny", "plotly", "shinydashboard", "leaflet")

# check packages that need to be installed.
packages.needed=setdiff(packages.used, 
                        intersect(installed.packages()[,1], 
                                  packages.used))
# install additional packages
if(length(packages.needed)>0){
  install.packages(packages.needed, dependencies = TRUE)
}


library(shiny)
library(plotly)
library(leaflet)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title='USA Education'),
  skin = "purple",
  dashboardSidebar(
    selectInput("major", label = "Major", 
                choices = c("None" ,"Agriculture"="agriculture", "Architecture",
                            "Biology"="Bio","Business", "Computer Science"="CS", 
                            "Education"="Edu", "Engineering", "History", "Math and Statistics"="MathStat",
                            "Nature Resources"="NatureResource", "Psychology", "Social Science"="SocialScience"), selected = "None"),
    selectInput("schtype", label="Type of School",
                choices = c("None","Private for-profit", "Private nonprofit", "Public"),selected= "None"),
    selectInput("citytype", label = "Type of City",
                choices = c("None", "City", "Rural", "Suburb","Town"),selected = "None"),
    hr(),
    verbatimTextOutput("select"),
    sliderInput("rank","Academic performance",0,100,20),
    sliderInput("AvgCost","Average Cost of Attendance",0, 100,20),
    sliderInput("Earn","Earnings& Jobs",0, 100, 20),
    sliderInput("CrimeRate","Social Security",0, 100, 20),
    sliderInput("HappyRank","Life quality",0, 100, 20),
    submitButton("Submit",width='100%')
    
  ),
  dashboardBody(
    fluidRow(
      tabBox(width=12,
             tabPanel(title="Map",width = 12,solidHeader = T,leafletOutput("map")),
             tabPanel(title="bar chart",width=12,plotlyOutput("bchart")),
             tabPanel(title="density",plotlyOutput("2"))),
      
      
      mainPanel(
        tabsetPanel(
          tabPanel('Ranking',
                   dataTableOutput("tablerank"),
                   tags$style(type="text/css", '#myTable tfoot {display:none;}')),
          tabPanel('Personalized Ranking',
                   dataTableOutput("tablerank2"),
                   tags$style(type="text/css", '#myTable tfoot {display:none;}'))
        )
      )
    )
  )
)
