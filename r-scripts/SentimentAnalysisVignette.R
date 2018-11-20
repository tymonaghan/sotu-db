#https://cran.r-project.org/web/packages/SentimentAnalysis/vignettes/SentimentAnalysis.html

#### load libraries ####
library(SentimentAnalysis)
library(tm)

#### setwd, build corpus ####
setwd("C:/Users/tnmon/git/sotu-db/speeches-ucsb-pres-project")
SOTUs = Corpus(DirSource("./"))

sentiment = analyzeSentiment(SOTUs)

dtm = preprocessCorpus(SOTUs)
convertToDirection(analyzeSentiment(dtm)$SentimentQDAP)

sentiment$SentimentQDAP

table(convertToBinaryResponse(sentiment$SentimentLM))

SOTUs[[which.max(sentiment$SentimentLM)]]

# View summary statistics of sentiment variable
summary(sentiment$SentimentLM)
# Visualize distribution of standardized sentiment variable
hist(scale(sentiment$SentimentLM))

# Compute cross-correlation 
cor(sentiment[, c("SentimentLM", "SentimentHE", "SentimentQDAP")])

countWords(SOTUs)
countWords(SOTUs, removeStopwords=FALSE)

library (ggplot2)

plotSentiment(sentiment, x = NULL, cumsum = FALSE, xlab = "SOTU",
              ylab = "Sentiment")+
  ggtitle("Sentiment in State of the Union addresses")

preprocessCorpus(SOTUs, language = "english", stemming = TRUE,
                 verbose = TRUE, removeStopwords = TRUE)

ruleSentiment(dtm, d)

data(DictionaryGI)
str(DictionaryGI)
dict.GI <- loadDictionaryGI()

d = SentimentDictionaryBinary(DictionaryGI$positive,DictionaryGI$negative)

analyzeSentiment(dtm)


