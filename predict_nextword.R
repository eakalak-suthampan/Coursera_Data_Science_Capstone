library(stringr)

# search term in ngram using binary search of data.table
search_ngram <- function(ngram, search_term) {
        library(stringr)
        search_term <- tolower(gsub("[()]","",search_term))
        search_term <- gsub("[^('.)[:alnum:] ]","",search_term)
        tmp <- ngram[.(search_term), nomatch = 0L]
        if (nrow(tmp) == 0) {
                return(as.data.table(data.frame(current_state=NULL, next_state=NULL,count=NULL)))
        }
        tmp[order(tmp$count,decreasing = TRUE),]
}

# predict nextwords from last 3 words input
predict_nextwords <- function(last_3_words, top=3) {
        # make sure input is last 3 words
        tmp <- unlist(strsplit(last_3_words,"\\s+"))
        len <- length(tmp)
        if(len==2) {tmp <- c("na",tmp); len <- 3}
        if(len==1) {tmp <- c("na","na",tmp); len <- 3}
        tokens <- NULL
        tokens[1] <- tmp[len-2]
        tokens[2] <- tmp[len-1]
        tokens[3] <- tmp[len] 
        
        # search input term on fourgram
        # return results on fourgram if number of results >= top 
        A <- search_ngram(fourgram, paste(tokens[1], tokens[2], tokens[3], sep=" "))
        if(nrow(A) >= top) {
                return(c(setdiff(A$next_state,""))[1:top])
        }
        # if results are not enough, backoff to trigram and return A union (B - A)
        B <- search_ngram(trigram, paste(tokens[2], tokens[3], sep=" "))
        if(nrow(A) + nrow(B) >= top) {
                return(c(setdiff(A$next_state,""), setdiff(B$next_state, A$next_state))[1:top])
        }
        # if results are not enough, backoff to bigram and return A union (B - A) union (C - B)
        C <- search_ngram(bigram, tokens[3])
        if(nrow(A) + nrow(B) + nrow(C) >= 1) {
                return(c(setdiff(A$next_state,""), setdiff(B$next_state, A$next_state), setdiff(C$next_state, B$next_state))[1:top])
        }
        # if not found at all then return just most common words
        return(c("the","on","a","to","of")[1:top])
}
