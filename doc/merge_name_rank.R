# Load required libraries
packages.used=c("readr", "data.table")
packages.needed=setdiff(packages.used, 
                        intersect(installed.packages()[,1], 
                                  packages.used))
if(length(packages.needed)>0){
  install.packages(packages.needed, dependencies = TRUE,
                   repos='http://cran.us.r-project.org')
}


library(dplyr)
library(data.table)

# Read in files
howdy<-fread("data/MERGED2014_15_PP.csv",select=4,col.names="Name")
howdy$Ranking<-rep(NA,nrow(howdy))
howdy$ID<-seq(1:nrow(howdy))
ranking<-fread("data/ranking_forbes_2016.csv",skip=1)

# Merge the two datasets
result1<-
  left_join(ranking,howdy,by="Name")

result2<-result1%>%
  filter(is.na(ID))%>%
  rowwise()%>%
  mutate(ID=agrep(Name,howdy$Name,ignore.case=T,max.distance = 0.1, useBytes = FALSE)[1])
  
result<-bind_rows(result1,result2)%>%
  filter(!is.na(ID))%>%
  arrange(Rank)%>%
  mutate(Rank=seq(1:nrow(result))) %>%
  select(Rank,ID)

# Write output
output <- left_join(howdy,result,by="ID") %>%
  select(Name,Rank) %>%
  write_csv("output/name_ranking.csv")

