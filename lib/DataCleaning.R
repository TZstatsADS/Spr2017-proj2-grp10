educ <- read.csv("MERGED2014_15_PP.csv", stringsAsFactors = F, header =T, fileEncoding="latin1")
educ_update<- educ[, 4:7] 
colnames(educ_update) <- c("Name", "City", "State", "Zip")
educ_update$Latitude <- educ$LATITUDE
educ_update$Longitude <- educ$LONGITUDE
educ_update$ADMrate <- educ$ADM_RATE
educ_update$Ownership <- educ$CONTROL
educ_update$Setting <- educ$CCSIZSET # carneige classification -- size and setting
educ_update$SAT <- educ$SAT_AVG
educ_update$AvgCost <- as.numeric(educ$COSTT4_A) #average cost of attendence
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

#-----------------------------------------------------------------------
#                 Mergeing data
#
#

#ranking_data <- read.csv("../output/name_ranking.csv")
# solve for comma slash problem
ranking <- ranking[order(ranking$Name), ]
a <- educ_update[order(educ_update$Name), ]
a$Name <- gsub("-", ", ", a$Name)
total <- merge(ranking, a, by = "Name")
# ranking_edu <- total[!is.na(total$Rank), ]
# a_1 <- apply(a, "Name", gsub, patt="-", replace=", ")