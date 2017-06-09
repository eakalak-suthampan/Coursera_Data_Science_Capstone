library(data.table)

# load ngrams from the saved files
fourgram <- fread("alldata_fourgram_state.csv",sep = ",",header = FALSE,skip = 1,drop = 1)
names(fourgram) <- c("current_state","next_state","count")
trigram <- fread("alldata_trigram_state.csv",sep = ",",header = FALSE,skip = 1,drop = 1)
names(trigram) <- c("current_state","next_state","count")
bigram <- fread("alldata_bigram_state.csv",sep = ",",header = FALSE,skip = 1,drop = 1)
names(bigram) <- c("current_state","next_state","count")
        
# drop the same search terms (current_state) that below than top 5 of count
fourgram[, enum := 1:.N, by = current_state]
trigram[, enum := 1:.N, by = current_state]
bigram[, enum := 1:.N, by = current_state]
fourgram <- fourgram[enum <=5, 1:3]
trigram <- trigram[enum <=5, 1:3]
bigram <- bigram[enum <=5, 1:3]

# prune more data
fourgram <- fourgram[fourgram$count > 2, ]
#trigram <- trigram[trigram$count > 3, ]
#bigram <- bigram[bigram$count > 3, ]
        
# set binary search on the current_state column
setkey(fourgram,current_state)
setkey(trigram,current_state)
setkey(bigram,current_state)
        