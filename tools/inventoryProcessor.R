library(dplyr)
library(RCurl)
library(rjson)
setwd("~/Code/datasd/src")

invSheetURL <- "https://docs.google.com/spreadsheets/d/1LAx0GyM-HNbqsKg5zp-sKB2ieQ5nQQChWgazBuqy8d4/pub?gid=970785642&single=true&output=csv"
invURL <- getURL(invSheetURL)
inventory <- read.csv(text = invURL, stringsAsFactors = FALSE)

file.remove("./_data/inventory.csv")

write.csv(inventory, "./_data/inventory.csv", row.names = FALSE)
write.csv(inventory, "./assets/data/inventory.csv", row.names = FALSE)

invByCat <- group_by(inventory, Category) %>% 
    count(Category) %>% 
    rename(NumDatasets = n)
inv_by_cat <- toJSON(as.list(invByCat))
write(inv_by_cat, "./assets/data/inv_by_cat.json")