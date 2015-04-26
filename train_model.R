load("corpus.Rdata")
suppressWarnings(library(RWeka))
suppressWarnings(library(tm))

## Support Tokenization for bigrams and trigrams (Create functions off NGramTokenizer)
UnigramTokenizer <- function(x) NGramTokenizer(x, control = Weka_control(min = 1, max = 1))
BigramTokenizer  <- function(x) NGramTokenizer(x, control = Weka_control(min = 2, max = 2))
TrigramTokenizer <- function(x) NGramTokenizer(x, control = Weka_control(min = 3, max = 3))
QuadgramTokenizer <- function(x) NGramTokenizer(x, control = Weka_control(min = 4, max = 4))

#tdmUnigram <- TermDocumentMatrix(corpus, control = list(tokenize = UnigramTokenizer))
#tf <- sort(rowSums(as.matrix(tdmUnigram)), decreasing=TRUE)
#tdmUnigram <- data.frame(term=names(tf), frequency=tf)

tdmBigram <- TermDocumentMatrix(corpus, control = list(tokenize = BigramTokenizer))
tf2 <- sort(rowSums(as.matrix(tdmBigram)), decreasing=TRUE)
pred2 <- sub(".*[ ]", "", names(tf2))
baseTerms2 <- sub("\\s([^\\s]*)$", "", names(tf2))
tdmBigram <- data.frame(base=baseTerms2, pred= pred2, frequency=tf2)

tdmTrigram <- TermDocumentMatrix(x = corpus, control = list(tokenize = TrigramTokenizer))
tf3 <- sort(rowSums(as.matrix(tdmTrigram)), decreasing=TRUE)
pred3 <- sub(".*[ ]", "", names(tf3))
baseTerms3 <- sub("\\s([^\\s]*)$", "", names(tf3))
tdmTrigram <- data.frame(base=baseTerms3, pred= pred3, frequency=tf3)

tdmQuadgram <- TermDocumentMatrix(x = corpus, control = list(tokenize = QuadgramTokenizer))
tf4 <- sort(rowSums(as.matrix(tdmQuadgram)), decreasing=TRUE)
pred4 <- sub(".*[ ]", "", names(tf4))
baseTerms4 <- sub("\\s([^\\s]*)$", "", names(tf4))
tdmQuadgram <- data.frame(base=baseTerms4, pred= pred4, frequency=tf4)

# Save data frames
#save(tdmBigram, file = "bigram.Rdata")
#save(tdmTrigram, file = "trigram.Rdata")
#save(tdmQuadgram, file = "quadgram.Rdata")
save(tdmBigram, tdmTrigram, tdmQuadgram, file = "ngram.RData")
