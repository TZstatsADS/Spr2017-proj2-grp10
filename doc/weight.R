packages.used=c("dplyr", "data.table")
packages.needed=setdiff(packages.used, 
                        intersect(installed.packages()[,1], 
                                  packages.used))
if(length(packages.needed)>0){
  install.packages(packages.needed, dependencies = TRUE,
                   repos='http://cran.us.r-project.org')
}


library(dplyr)
library(data.table)

data<-fread("data/finaldata.csv")
w1<-input$w1
w2<-input$w2
w3<-input$w3
w4<-input$w4
w5<-input$w5
data<-data %>%
  select(Name,Rank,AvgCost,CrimeRate,HappyRank)%>%
  arrange(AvgCost,Rank)%>%
  mutate(AvgCost=seq(1:nrow(data)))%>%
  arrange(CrimeRate,Rank)%>%
  mutate(CrimeRate=seq(1:nrow(data)))%>%
  arrange(HappyRank,Rank)%>%
  mutate(HappyRank=seq(1:nrow(data)))%>%
  mutate(new_rank=w1*Rank+w2*AvgCost+w3*CrimeRate+w4*HappyRank) %>%
  arrange(new_rank)
  


