library(dplyr)
library(ggplot2)
library(plotly)
#install_local("~/Code/WufooR")
library(WufooR)
setwd("./")

wufooApiKey <- Sys.getenv("wufoo_api_key")

options(Wufoo_Name = "sdcdo", Wufoo_API = wufooApiKey)

voteFormId <- "qd3zs9p0zgyxvm"
iterator <- 0
pageSize <- 100

inventory <- read.csv("../src/_data/inventory.csv")

colors <- c(
    "#0098db",
    "#00549f",
    "#007b69",
    "#9c6114",
    "#ffa02f",
    "#37424a",
    "#00c7b2",
    "#fcd900"
)
 

getVotes <- function() {

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
    
    votesFull
}

votesFull <- getVotes()

inventoryStats <- function() {
   uniqueVotes <- length(unique(votesFull$vMail)) 
   totalVotes <- nrow(votesFull)
}

inventoryCatBreakdown <- function(inventory) {
    invByCat <- group_by(inventory, Category) %>% 
        count(Category) %>% 
        rename(NumDatasets = n)
    
    vCatBreakdown <- group_by(votesFull, Category) %>%
        count(Category) %>%
        rename(NumDatasets = n)
   
    p <- plot_ly(invByCat, x=Category, y=NumDatasets, 
                 type = "bar",  
                 name="Inventory", marker=list(color=colors[1]))
    p <- add_trace(p, data = vCatBreakdown, 
                   x=Category, y=NumDatasets, 
                   type="bar",  
                   name="Votes", marker = list(color=colors[2])) %>%
        
        layout(margin = list(b = 150))
    p
    
    htmlwidgets::saveWidget(as.widget(p), "invByCat.html")
}

topVoted <- function() {
    topVotes <- select(votesFull, vDatasetId) %>%
        group_by(vDatasetId) %>%
        count(vDatasetId) %>%
        arrange(desc(n)) 
    
    top <- topVotes[1:5, ] %>%
        inner_join(inventory, by=c("vDatasetId" = "ID")) %>%
        select(vDatasetId, nVotes = n, Category, Description)
    
    topWithDesc <- top %>%
        inner_join(votesFull, by="vDatasetId")
    
    p <- plot_ly(top, x=Description, y=nVotes, 
                 type = "bar", colors = colors,
                 color = factor(Category)) %>%
        layout(margin = list(b = 200, l = 100))
    
    p
    
    htmlwidgets::saveWidget(as.widget(p), "topVotes.html")
}
