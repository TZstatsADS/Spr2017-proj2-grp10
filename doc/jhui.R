library(shiny)

library(shinydashboard)

dashboardPage(
  
  dashboardHeader(title='USA Education'),
  skin = "purple",
  dashboardSidebar(
    selectInput("major", label = "Major", 
                choices = c("None" ,"Agriculture", "Architecture",
                            "Bio","Business", "Computer Science", 
                            "Education", "Engineering", "History", "Math & Statistics",
                            "Nature Resources", "Psychology", "Social Science"), selected = "None"),
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
      column(width=8,box(title="Map",width = NULL,solidHeader = T,leafletOutput("map"))),
      #column(width=4,box(title="Rank",width = NULL,solidHeader = T,
      #leafletOutput("rank"), dataTableOutput("tablerank"), textInput("text", "Rank range:"),br(),
      #actionButton("apply","Apply")))
      #),
      hr(),
      fluidRow(
        box(
          title="barplot",width = 4, background = "navy",
          "A box with a solid black background"
        ),
        box(
          title = "density", width = 4, background = "navy",
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
                    
                    
      ),
      mainPanel(
        tabsetPanel(
          tabPanel('General',
                   fluidRow(column(7,leafletOutput("general",height=700)),
                            column(5,leafletOutput("density",height=700)))
          ),
          tabPanel('Ranking',
                   dataTableOutput("tablerank"),
                   tags$style(type="text/css", '#myTable tfoot {display:none;}'))
        )
      ))))

