##### Load libraries #####
library(SentimentAnalysis)
library(tm)
library (ggplot2)

##### build Corpus from wd ####
setwd("C:/Users/tnmon/git/sotu-db/speeches-ucsb-pres-project")
SOTUs = Corpus(DirSource("./"))

#### create sentiment table ####
sentiment = analyzeSentiment(SOTUs)

###### plot data and write file #####
#redirect output to PNG
png("../temp-samples/simpleplot.png")
#plot the sentiment
plotSentiment(sentiment, x = NULL, cumsum = FALSE, xlab = "SOTU",
              ylab = "Sentiment")+
              ggtitle("Sentiment in State of the Union addresses")
#stop redirecting output (back to stdout)
dev.off()