#### handle input arguments ####
args = commandArgs(trailingOnly=TRUE)
# sentimentDirection if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  message("using searchterm: " , toString(args[1]))
}

userQuery = toString(args[1])
#userQuery= toString("harm")

#### load packages ####
library(stringr)
library(glue)
library(SentimentAnalysis)
library(tidytext)
library(tidyverse)

####load workspace - this determines corpus ####
load("../r-env/tidy-workspace-2.RData")

#### set REGEX versions of query ####
regexUserQuery = paste0("(?i)",userQuery)
regexUserQuerySentence = paste0("[^.]*",regexUserQuery,"[^.]*\\.")

stringCountResult = str_count(tidyWords$word, regexUserQuery)
stringCountSum = sum(stringCountResult)
remove(stringCountResult)
tempDir=file("../output/matchCount.txt")
sink(tempDir)
writeLines(toString(stringCountSum))
sink()

#### build dataFrames ####
stringMatchResult = data_frame()
stringMatchResult = tidySentences[which(tidySentences$word == str_match_all(tidySentences$word, regexUserQuerySentence)), ]

#### write matching sentences to file
tempDir=file("../output/matchSentences.txt")
sink(tempDir)
writeLines(unlist(lapply(stringMatchResult$word, paste, collapse=" ")))
sink()


#### sentimentAnalysis ####
sentiment = analyzeSentiment(unlist(stringMatchResult$word))
sentimentDirection = convertToDirection(sentiment)
stringMatchResult=cbind(sentimentDirection$SentimentGI,sentimentDirection$SentimentHE,sentimentDirection$SentimentLM,sentimentDirection$SentimentQDAP,stringMatchResult)
names(stringMatchResult) = c("GIsentiment","HEsentiment","LMsentiment","QDAPsentiment","sentenceText","fileName","year","sentenceNumber","potusName")


tempDir=file("../output/sentimentDirections.txt")
sink(tempDir)


for (i in 1:nrow(stringMatchResult)){
  writeLines(paste0(stringMatchResult$sentenceText[i],
                    "</div>",
                    "<div class='w3-container w3-cell w3-cell-middle w3-mobile w3-light-gray'>",
                    "year=",
                    stringMatchResult$year[i],
                    "<br>sentence n=",
                    stringMatchResult$sentenceNumber[i],
                    "<br>POTUSname=",
                    stringMatchResult$potusName[i],
                    "</div>",
                    "<div class='w3-container w3-cell w3-cell-middle w3-right w3-mobile' style='min-width:100px'>",
                    "GI: ",str_replace_all(stringMatchResult$GIsentiment[i],c("positive"=iconThumbsUp, "neutral"=iconHalfStar, "negative"=iconThumbsDown)),
                    "<br>",
                    "HE: ",str_replace_all(stringMatchResult$HEsentiment[i],c("positive"=iconThumbsUp, "neutral"=iconHalfStar, "negative"=iconThumbsDown)),
                    "<br>",
                    "LM: ",str_replace_all(stringMatchResult$LMsentiment[i],c("positive"=iconThumbsUp, "neutral"=iconHalfStar, "negative"=iconThumbsDown)),
                    "<br>",
                    "QDAP: ",str_replace_all(stringMatchResult$QDAPsentiment[i],c("positive"=iconThumbsUp, "neutral"=iconHalfStar, "negative"=iconThumbsDown))))
}
sink()

png("../output/sentimentMatchChart.png", width=1000, height=450)
plotSentiment(sentiment, x=stringMatchResult$year+(0.001*stringMatchResult$sentenceNumber), xlab="year of occurrence") +
  ggtitle(paste0("sentiment by year for each occurence of \"",userQuery,"\"")) +
  geom_point(shape=18, size=3) +
  geom_smooth(color="purple")+
  theme_minimal()
dev.off()
