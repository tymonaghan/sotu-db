#### handle input arguments ####
args = commandArgs(trailingOnly=TRUE)
# sentimentDirection if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  message("using searchterm: " , toString(args[1]))
}

userQuery = toString(args[1])
#userQuery= toString("military")

#### load packages ####
library(stringr)
library(glue)
library(SentimentAnalysis)
library(tidytext)
library(tidyverse)
load("../r-env/tidytokens-sample.RData")

#### set REGEX versions of query ####
regexUserQuery = paste0("(?i)",userQuery)
regexUserQuerySentence = paste0("[^.]*",regexUserQuery,"[^.]*\\.")

stringCountResult = str_count(tokens1989, regexUserQuery)
stringCountSum = sum(stringCountResult)
remove(stringCountResult)
tempDir=file("../output/matchCount.txt")
sink(tempDir)
writeLines(toString(stringCountSum))
sink()

#### build dataFrames ####
stringMatchResult= str_match_all(clearText1989, regexUserQuerySentence) %>% compact
tokenMatches = tokens1989[which(tokens1989$token == str_match_all(tokens1989$token,regexUserQuery)), ]
theOne = data_frame("sentenceNumbers" = unlist(tokenMatches$sentence), "sentenceTexts" = unlist(stringMatchResult) )

tempDir=file("../output/matchSentences.txt")
sink(tempDir)
writeLines(unlist(lapply(stringMatchResult, paste, collapse=" ")))
sink()

#### sentimentAnalysis ####
sentiment = analyzeSentiment(unlist(theOne$sentenceTexts))
sentimentDirection = convertToDirection(sentiment)
theOne=cbind(sentimentDirection$SentimentGI,sentimentDirection$SentimentHE,sentimentDirection$SentimentLM,sentimentDirection$SentimentQDAP,theOne)

#sentimentDirection$sentence = stringMatchResult
tempDir=file("../output/sentimentDirections.txt")
sink(tempDir)


for (i in 1:length(stringMatchResult)){
  writeLines(paste0("<div class='w3-cell-row w3-border w3-hover-pale-blue'>",
                   "<div class='w3-container w3-cell w3-cell-middle w3-twothird'style='padding-top:10px,padding-bottom:10px'>",
               stringMatchResult[i],
               "</div>",
               "<div class='w3-container w3-cell w3-cell-middle style='width:75px'>",
               "sentence n=", 
               theOne$sentenceNumbers[i],
               "</div>",
               "<div class='w3-container w3-rest w3-cell w3-cell-middle w3-right w3-padding w3-hover-pale-blue'>",
                   "GI: ",str_replace_all(sentimentDirection$SentimentGI[i],c("positive"=thumbsUp, "neutral"=neutralIcon, "negative"=thumbsDown)),"<br>",
                   "HE: ",str_replace_all(sentimentDirection$SentimentHE[i],c("positive"=thumbsUp, "neutral"=neutralIcon, "negative"=thumbsDown)),"<br>",
                   "LM: ",str_replace_all(sentimentDirection$SentimentLM[i],c("positive"=thumbsUp, "neutral"=neutralIcon, "negative"=thumbsDown)),"<br>",
                   "QDAP: ",str_replace_all(sentimentDirection$SentimentQDAP[i],c("positive"=thumbsUp, "neutral"=neutralIcon, "negative"=thumbsDown)),
                    "</div>","</div>"))
}
sink()

png("../output/sentimentMatchChart.png", width=600, height=300)
plotSentiment(sentiment, x=theOne$sentenceNumbers, xlab="sentence of occurrence") +
  ggtitle(paste0("Sentiment for each occurence of \"",userQuery,"\"")) +
  geom_point(shape=18, size=3) +
  geom_smooth(color="purple")+
  theme_minimal() 
dev.off()
