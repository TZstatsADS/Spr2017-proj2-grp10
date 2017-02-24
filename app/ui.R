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
  dashboardHeader(title='UNI-MATE'),
  skin = "red",
  dashboardSidebar(
    sidebarMenu(id='sidebarmenu',
                menuItem("Overview",tabName="Overview",icon=icon("book")),
                menuItem("Who are we?", tabName="Intro", icon=icon("group")),
                menuItem("App Manual",tabName="Manual",icon=icon("question-circle")),
                menuItem("University Search",tabName="University-Search",icon=icon("search"))
    ),
    textOutput("text0"),
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
    textOutput("text1"),
    sliderInput("rank","Academic performance",0,100,20),
    sliderInput("AvgCost","Average Cost of Attendance",0, 100,20),
    sliderInput("Earn","Earnings & Jobs",0, 100, 20),
    sliderInput("CrimeRate","Safety",0, 100, 20),
    sliderInput("HappyRank","Happiness/Life quality",0, 100, 20),
    submitButton("Submit",width='100%')
    
  ),
  dashboardBody(
    tabItems(
      
      
      tabItem(tabName = "Overview",
              mainPanel(
                
                img(src = "background.jpg",height=450,width=1150)
              )),
      
      tabItem(tabName = "Manual",
              mainPanel(
               textOutput("explain1"),
               hr(),
               textOutput("explain2"),
               hr(),
               textOutput("explain3")
              )),
      
      tabItem(tabName = "Intro",
              mainPanel(
                
               textOutput("introduction")
              )),
      
      tabItem(tabName = "University-Search",
              
              fluidRow(
                tabBox(width=12,
                       tabPanel(title="Map",width = 12,solidHeader = T,leafletOutput("map")),
                       tabPanel(title="ADM Rate",width=12,plotlyOutput("ADMchart")),
                       tabPanel(title="Avg Cost",plotlyOutput("cost")), 
                       tabPanel(title="Earnings",width=12,plotlyOutput("earnchart")),
                       tabPanel(title="Crime Rate",plotlyOutput("crimer"))),
                
                
                tabBox(width = 12,
                       
                       tabPanel('Ranking',
                                dataTableOutput("tablerank"),
                                tags$style(type="text/css", '#myTable tfoot {display:none;}')),
                       tabPanel('Personalized Ranking',
                                dataTableOutput("tablerank2"),
                                tags$style(type="text/css", '#myTable tfoot {display:none;}')))))
      
      
      
      
    )))