#### handle input arguments ####
args = commandArgs(trailingOnly=TRUE)
# sentimentFrame if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  message("using searchterm: " , toString(args[1]))
}

#userQuery = toString(args[1])
userQuery= toString("together")

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
#### print to screen to debug ####
#userQuery
#regexUserQuery
#regexUserQuerySentence

#### count and sink to output/matchCount.txt ####
stringCountResult = str_count(tokens1989, regexUserQuery)
stringCountSum = sum(stringCountResult)
tempDir=file("../output/matchCount.txt")
sink(tempDir)
writeLines(toString(stringCountSum))
sink()

#### stringMatchResult from clearText1989 ####
#stringMatchResult= str_match_all(clearText1989, regexUserQuerySentence)
#squish out empty frames. not needed with theBestDataFrame:
#stringMatchResult = stringMatchResult[lapply(stringMatchResult,length)>0]

#### stringMatchResult from tokens1989 ####
#stringMatchResult= str_match_all(tokens1989$token,regexUserQuery)
#turn into a data frame:
#stringMatchResultdf  = data.frame(matrix(unlist(stringMatchResult)), stringsAsFactors=FALSE)

#### data frame from tokens1989 ####
#fuck yeah. this returns the whole rows from tokens1989, so $sentence is one of the cols
theBestDataFrame = tokens1989[which(tokens1989$token == str_match_all(tokens1989$token,regexUserQuery)), ]
#this returns the sentence number
theBestDataFrame$sentence[2]

tempDir=file("../output/matchSentences.txt")
sink(tempDir)
writeLines(unlist(lapply(stringMatchResult, paste, collapse=" ")))
sink()

#### sentimentAnalysis ####
sentiment = analyzeSentiment(unlist(stringMatchResult))

sentimentDirection = convertToDirection(sentiment)
sentimentDirection$SentimentGI[1]
sentimentFrame = sentimentDirection
#sentimentFrame$sentence = stringMatchResult
tempDir=file("../output/sentimentDirections.txt")
sink(tempDir)
thumbsUp = toString("<i class='fa fa-thumbs-up' style='color:green'></i>")
neutralIcon = toString("<i class='fa fa-star-half-o' style='color:orange'></i>")
thumbsDown = toString("<i class='fa fa-thumbs-o-down' style='color:red'></i>")

for (i in 1:length(stringMatchResult)){
  writeLines(paste(stringMatchResult[i],
                   "</div><div class='w3-rest w3-cell-middle w3-right w3-padding w3-hover-pale-blue'>",
                   "GI: ",str_replace_all(sentimentFrame$SentimentGI[i],c("positive"=thumbsUp, "neutral"=neutralIcon, "negative"=thumbsDown)),"<br>",
                   "HE: ",str_replace_all(sentimentFrame$SentimentHE[i],c("positive"=thumbsUp, "neutral"=neutralIcon, "negative"=thumbsDown)),"<br>",
                   "LM: ",str_replace_all(sentimentFrame$SentimentLM[i],c("positive"=thumbsUp, "neutral"=neutralIcon, "negative"=thumbsDown)),"<br>",
                   "QDAP: ",str_replace_all(sentimentFrame$SentimentQDAP[i],c("positive"=thumbsUp, "neutral"=neutralIcon, "negative"=thumbsDown))))
}
sink()

png("../output/sentimentMatchChart.png", width=600, height=300)
plotSentiment(sentimentFrame)
dev.off()
