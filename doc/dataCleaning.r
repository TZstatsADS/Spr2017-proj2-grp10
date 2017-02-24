# Load required libraries
packages.used=c("dplyr", "data.table","readr")
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

# Read in files
educ<-fread("data/MERGED2014_15_PP.csv",select=4,col.names="Name")
educ$Ranking<-rep(NA,nrow(educ))
educ$ID<-seq(1:nrow(educ))
ranking<-fread("data/ranking_forbes_2016.csv",skip=1)


#-----------------------------------------------------------------------
#                 Merging data
#
#

## Merge ranking and the original dataset
result1<-
  left_join(ranking,educ,by="Name")

result2<-result1%>%
  filter(is.na(ID))%>%
  rowwise()%>%
  mutate(ID=agrep(Name,educ$Name,ignore.case=T,max.distance = 0.1, useBytes = FALSE)[1])
  
result<-bind_rows(result1,result2)%>%
  filter(!is.na(ID))%>%
  arrange(Rank)
result<-mutate(result,Rank=seq(1:nrow(result))) %>%
  select(Rank,ID)

# Write output
output <- left_join(educ,result,by="ID") %>%
  select(Name,Rank) %>%
  write_csv("output/name_ranking.csv")

earning<- read.csv("data/Earning.csv", header = T)
earning <- earning[, 2:3]


## Select columns needed
educ<-fread("data/MERGED2014_15_PP.csv")

educ_update<- educ[, 4:7] 
colnames(educ_update) <- c("Name", "City", "State", "Zip")
educ_update$URL <- educ$INSTURL
educ_update$Latitude <- educ$LATITUDE
educ_update$Longitude <- educ$LONGITUDE
educ_update$ADMrate <- educ$ADM_RATE
educ_update$Ownership <- educ$CONTROL
educ_update$Citytype<- educ$LOCALE
educ_update$SAT <- educ$SAT_AVG
educ_update$AvgCost <- as.numeric(educ$COSTT4_A) #average cost of attendence
# educ_update$Earning <- earning_8
# no unemployment rate
educ_update$Major_agriculture <- educ$CIP01BACHL
educ_update$Major_NatureResource <- educ$CIP03BACHL
educ_update$Major_Architecture <- educ$CIP04BACHL
educ_update$Major_CS <- educ$CIP11BACHL
educ_update$Major_Edu <- educ$CIP13BACHL
educ_update$Major_Engineering <- educ$CIP14BACHL
educ_update$Major_Bio <- educ$CIP26BACHL
educ_update$Major_MathStat <- educ$CIP27BACHL
educ_update$Major_Psychology <- educ$CIP42BACHL
educ_update$Major_SocialScience <- educ$CIP45BACHL
educ_update$Major_Business <- educ$CIP52BACHL
educ_update$Major_History <- educ$CIP54BACHL

dir.create("output/CleanData.csv")

write.csv(educ_update, file = "output/CleanData.csv")

## Merge ranking and earning
ranking_data <- read.csv("output/name_ranking.csv")
ranking_data <- ranking_data[order(ranking_data$Name), ] %>%  filter(!is.na(Rank))
# solve for comma slash problem
# ranking <- ranking[order(ranking$Name), ]
# a <- educ_update[order(educ_update$Name), ]
# a$Name <- gsub("-", ", ", a$Name)
total<- merge(ranking_data, educ_update, by="Name")
total<- total[order(total$Rank),]
rownames(total)<- seq(1:nrow(total))
earnings_red<- merge(ranking_data, earning, by="Name")
earnings_red<- earnings_red[order(earnings_red$Rank),]
rownames(earnings_red)<- seq(1:nrow(earnings_red))
earnings_red<- earnings_red[,-1]
final<- merge(total, earnings_red, by="Rank")
colnames(final)[2]<-"Name"
# ranking_edu <- total[!is.na(total$Rank), ]
# a_1 <- apply(a, "Name", gsub, patt="-", replace=", ")
write.csv(total, file = "output/DataWithRank.csv")
write.csv(final, file = "output/DataWithRANDE.csv")

##- Merge crime & happiness data
crime<-read.csv("data/CrimeData_final.csv")
happy<-read.csv("data/Happinessdata.csv")
datarank<-read.csv("output/DataWithRANDE.csv")


crimehappy<-merge(crime, happy, by="State")
colnames(crimehappy)[3]<-"State"
crimehappy<-crimehappy[,-1]


FinalData<-merge(datarank, crimehappy, by="State") %>% arrange(Rank) 
FinalData<-FinalData[, -2] %>% write_csv("output/final2data.csv")


#-----------------------------------------------------------------------
#Convert city type data and school type into character vector
dat<- read.csv("output/final2data.csv")
for (i in 1:nrow(dat)) {
  if (dat$Citytype[i]==11 | dat$Citytype[i]== 12 | dat$Citytype[i]==13) {
    dat$Citytype[i]<-"City"
  }
  else if (dat$Citytype[i]==21 | dat$Citytype[i]== 22 | dat$Citytype[i]==23) {
    dat$Citytype[i]<- "Suburb"
  }
  else if (dat$Citytype[i]==31 | dat$Citytype[i]== 32 | dat$Citytype[i]==33) {
    dat$Citytype[i]<- "Town"
  }
  else if (dat$Citytype[i]==41 | dat$Citytype[i]== 42 | dat$Citytype[i]==43){
    dat$Citytype[i]<- "Rural"
  }
}

for (i in 1:nrow(dat)) {
  if (dat$Ownership[i]==1){
    dat$Ownership[i]<-"Public"}
  else if (dat$Ownership[i]==2){
    dat$Ownership[i]<- "Private nonprofit"}
  else if (dat$Ownership[i]==3){
    dat$Ownership[i]<-"Private for-profit"}
  }
  
write.csv(dat, file = "output/final3data.csv")
