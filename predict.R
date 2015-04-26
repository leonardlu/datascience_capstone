library(stringr)
load("ngram.rdata")

###prediction function
predict3gram <- function(input) {
  ###clean the input
  #remove numbers, punctuations
  word <- gsub("[^a-zA-Z\n\']", " ", input)
  #convert all words to lowercase
  word <- tolower(word)
  ##remove extra spaces
  trim <- function(x) return(gsub("^ *|(?<= ) | *$", "", x, perl=T))
  word<-trim(word)      

  str <- unlist(str_split(word," "))
  len <- length(str)
  
  if (len>=3){
    ##3 words
    ngram<- paste(str[len-2],str[len-1],str[len])
    hit <- tdmQuadgram[tdmQuadgram$base == ngram,]
    #sgt<-sgt4g
    
    if(nrow(hit)==0){
      ##2 words
      ngram<- paste(str[len-1],str[len])
      hit <- tdmTrigram[tdmTrigram$base == ngram,]
      #sgt<-sgt3g
    }
    
    if(nrow(hit)==0){
      ##single word 
      ngram<- paste(str[len])
      hit<- tdmBigram[tdmBigram$base == ngram,]
      #sgt<-sgt2g
    }
  }
  
  if (len==2){
    ##bigram
    ngram<- paste(str[len-1],str[len])
    hit <- tdmTrigram[tdmTrigram$base == ngram,]
    #sgt<-sgt3g
    
    
    if(nrow(hit)==0){
      ##unigram 
      ngram<- paste(str[len])
      hit<- tdmBigram[tdmBigram$base == ngram,]
      #sgt<-sgt2g
    }    
  }
  
  
  if (len==1){
    ##unigram 
    ngram<- paste(str[len])
    hit<- tdmBigram[tdmBigram$base == ngram,]
    #sgt<-sgt2g   
  }
  #if no hit for all of them, return "the"
  if(nrow(hit)==0){return(paste(input,"the"))}
  
  ###prediction
  #hit$p <- sapply(hit$freq,FUN=function(x) sgt$p[sgt$r==x])
  # order by probability
  hit <- hit[with(hit,order(-frequency)),]
  #if (nrow(hit) <= 5)
  #  return paste(paste('[', input, hit[1:nrow(hit),]$pred,'\n]'))
  return(paste('[', input, hit[1:5,]$pred,'\n]'))
}