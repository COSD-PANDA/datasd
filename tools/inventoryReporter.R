library(dplyr)
#install_local("~/Code/WufooR")
library(WufooR)
setwd("~/Code/datasd/tools")

apiKey <- scan("./API_KEY", what="character")

options(Wufoo_Name = "sdcdo", Wufoo_API = apiKey)

voteFormId <- "qd3zs9p0zgyxvm"
iterator <- 0
pageSize <- 100

formEntriesCount <- form_entriesCount(formIdentifier = voteFormId)
formEntriesCount <- as.numeric(formEntriesCount)
votes <- form_entries(formIdentifier = voteFormId, showRequestURL = TRUE, pageStart = iterator, pageSize = pageSize)
iterator <- iterator + pageSize

while (iterator <= formEntriesCount) {
    temp_votes <- form_entries(formIdentifier = voteFormId, showRequestURL = TRUE, 
                pageStart = iterator, pageSize = pageSize)
    votes <- bind_rows(votes, temp_votes)
    iterator <- iterator + pageSize
}


inventory <- read.csv("../src/_data/inventory.csv")

votes$Vote <- gsub("ds_id_", "", votes$Vote)
names(votes) <- gsub(" ", ".", names(votes))
names(votes) <- gsub("\\?", "", names(votes))

votesFull <- select(votes, 
                    vFname = First.Name,
                    vLname = Last.Name,
                    vMail = Email,
                    vDatasetId = Vote,
                    reason = Why.do.you.think.we.should.prioritize.this.dataset.higher,
                    vDate = Date.Created) %>%
            mutate(vDatasetId = as.numeric(vDatasetId))

votesFull <- inner_join(votesFull, inventory, by=c("vDatasetId" = "ID"))
