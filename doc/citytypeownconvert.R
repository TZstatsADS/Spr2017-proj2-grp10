#Convert city type data and school type into character vector
dat<- read.csv("final2data.csv")
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
  
write.csv(dat, file = "final3data.csv")
