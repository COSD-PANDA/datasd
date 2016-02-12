library(dplyr)
setwd("~/Code/datasd/src")
inventory <- read.csv("_data/inventory.csv")
invByCat <- group_by(inventory, Category) %>% 
    count(Category) %>% 
    rename(NumDatasets = n)
t2 <- toJSON(as.list(invByCat))
write(t2, "./assets/data/inv_by_cat.json")