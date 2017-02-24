
#output panel:
absolutePanel(id = "controls", class = "panel panel-default", fixed = T, draggable = T, 
              top = 120, left = 20, right = "auto", bottom = "auto", width = 250, 
              height = "auto", h3("Outputs"), 
              h4("Center Coordinate"), 
              p(textOutput("click_address")), 
              p(strong("Earning after Graduation"), "Rank:", strong(textoutput("click_earn_rank", inline = T))), 
              plotlyOutput("click_rank_plot", height = "100"), 
              br(), 
              uiOutput("click_Earning_rank"), 
              plotlyOutput("click_Adm_rank", height = "100"),
              plotlyOutput("click_Cost_rank", height = "100"),
              plotlyOutput("click_SAT_rank", height = "100")
)




