#Building on top of DataWithRank
#Import crime and happiness datasets
library("readr")
crime<-read.csv("CrimeData_final.csv")
happy<-read.csv("Happinessdata.csv")
datarank<-read.csv("DataWithRANDE.csv")

#Merge happy and crime data
crimehappy<-merge(crime, happy, by="State")
colnames(crimehappy)[3]<-"State"
crimehappy<-crimehappy[,-1]

#Merge happycrime data into full DataWithRank dataset
FinalData<-merge(datarank, crimehappy, by="State") %>% arrange(Rank) 
FinalData<-FinalData[, -2] %>% write_csv("../data/final2data.csv")
