library(shiny)

library(shinydashboard)

dashboardPage(
  
  dashboardHeader(title='USA Education'),
  skin = "purple",
  dashboardSidebar(
    selectInput("select", label = "Major", 
                choices = list("None"=0 ,"Agriculture" = 1, "Architecture" = 2,
                               "Biology" = 3,"Business"=4, "Computer Science"=5, 
                               "Education"=6, "Engineering"=7, "History"=8, "Math & Statistics"=9,
                               "Nature Resources"=10, "Psychology"=11, "Social Science"=12), selected = 0),
    selectInput("select", label="Type of Schools",
                choices = list("None"=0,"Private for-profit"=1, "Private nonprofit"=2, "Public"=3),selected=0),
    selectInput("select", label = "Type of Cities",
                choices = list("None"=0, "City"=1, "Rural"=2, "Suburb"=3,"Town"=4),selected = 0),
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
      column(width=8,box(title="Map",width = NULL,solidHeader = T,leafletOutput("map"))),
      column(width=4,box(title="Rank",width = NULL,solidHeader = T,
                         leafletOutput("rank"),br(),textInput("text", "Rank range:"),br(),
                         actionButton("apply","Apply")))
  ),
  hr(),
  fluidRow(
    box(
      title="Visualization",width = 4, background = "navy",
      "A box with a solid black background"
    ),
    box(
      title = "Chart", width = 4, background = "navy",
      "A box with a solid light-blue background"
    ),
    box(
      title = "Summary",width = 4, background = "navy",
      "A box with a solid maroon background"
    )
  ),
 hr(),
 #pop-up
 absolutePanel(id = "controls", fixed= TRUE, draggable = TRUE,
               top = 120, left = "auto", right = 20, bottom = "auto", width = 320, height = "auto",
               textOutput("text",inline = T),
               plotOutput("chart")

               
 )
  )
)

