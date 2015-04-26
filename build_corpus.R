
suppressWarnings(library(R.utils))
suppressWarnings(require(knitr))
suppressWarnings(require(doMC))
registerDoMC(cores=4)

blogs <- readLines("en_US/en_US.blogs.txt")
news <- readLines("en_US/en_US.news.txt")
twitter <- readLines("en_US/en_US.twitter.txt")

train_prob <- rbinom(n = length(blogs), size = 1, prob = 0.03)
lines <- c(1:length(blogs))
writeLines(text = blogs[train_prob * lines], con = "en_US/training/en_US.blogs.training.txt")
#writeLines(text = blogs[abs(train_prob - 1) * lines], con = "en_US/test/en_US.blogs.test.txt")

train_prob <- rbinom(n = length(news), size = 1, prob = 0.03)
lines <- c(1:length(news))
writeLines(text = news[train_prob * lines], con = "en_US/training/en_US.news.training.txt")
#writeLines(text = news[abs(train_prob - 1) * lines], con = "en_US/test/en_US.news.test.txt")

train_prob <- rbinom(n = length(twitter), size = 1, prob = 0.03)
lines <- c(1:length(twitter))
writeLines(text = twitter[train_prob * lines], con = "en_US/training/en_US.twitter.training.txt")
#writeLines(text = twitter[abs(train_prob - 1) * lines], con = "en_US/test/en_US.twitter.test.txt")

#2) Cleaning and Tidying Data
#I used in built tm functions to tidy up the data.
suppressWarnings(library(RWeka))
suppressWarnings(library(tm))

corpus <- Corpus(DirSource("en_US/training"),readerControl=list(language="en"))

# Convert to Lower Case
corpus <- tm_map(corpus, content_transformer(tolower))
# Strip white spaces
corpus <- tm_map(corpus, stripWhitespace)
# Remove punctuation
corpus <- tm_map(corpus, removePunctuation)
# Remove stopwords
corpus <- tm_map(corpus, removeWords, stopwords('english'))
# Remove profanity (List is saved in a file called swear_words.txt)
profanities <- readLines("swear_words.txt")
corpus <- tm_map(corpus, removeWords, profanities)
# Remove numbers
corpus <- tm_map(corpus, removeNumbers)

save(corpus, file = "corpus.RData")