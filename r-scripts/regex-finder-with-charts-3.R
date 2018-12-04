#### handle input arguments ####
args = commandArgs(trailingOnly=TRUE)
# sentimentFrame if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  message("using searchterm: " , toString(args[1]))
}

#userQuery = toString(args[1])
userQuery= toString("men")

#### load packages ####
library(stringr)
library(glue)
library(SentimentAnalysis)
library(tidytext)
library(tidyverse)
library(tm)
load("../r-env/tidytokens-sample.RData")

#### set REGEX versions of query ####
regexUserQuery = paste0("(?i)",userQuery)
regexUserQuerySentence = paste0("[^.]*",regexUserQuery,"[^.]*\\.")

#### count and sink to output/matchCount.txt ####
stringCountResult = str_count(tokens1989, regexUserQuery)
stringCountSum = sum(stringCountResult)
tempDir=file("../output/matchCount.txt")
sink(tempDir)
writeLines(toString(stringCountSum))
sink()

#### match and create data frame ####

stringMatchResult= str_match_all(clearText1989, regexUserQuerySentence) %>% compact

tokenRows = data_frame("sentenceText" = stringMatchResult) %>%
  mutate("sentenceNumber" = )


#this returns the whole rows from tokens1989, so $sentence is one of the cols
filteredTokenRows = data_frame("sentenceText" = character(stringCountSum), stringsAsFactors=FALSE)

filteredTokenRows[ ,1] = 
  
  tokens1989[which(tokens1989$token == str_match_all(tokens1989$token,regexUserQuery)), ]

for (i in stringCountSum){
  tokenRows$sentenceNumber[i] = as.numeric(i)
}

tokens1989[which(tokens1989$token == str_match_all(tokens1989$token,regexUserQuery)), ]
butts = str_match_all(tokens1989$token,regexUserQuery) %>% compact
butts = compact(butts)

filteredTokenRows$sentence
#### extract sentence numbers ####
#create function:
GetSentences = function(sentNo){
  sentenceNumber=(filteredTokenRows$sentence[sentNo])
  message(sentenceNumber)
  #make a string of every word from tokens1989$sentence[sentenceNumber]
  sentence = data_frame("text"=tokens1989$token[which(tokens1989$sentence == sentenceNumber)])
  sentenceTwo = gsub("\\$", "dollars", sentence)
  sentenceThree = gsub("^c","", as.character(removePunctuation(as.character(sentenceTwo))))
  returner = sentenceThree
  return (returner)
}

#run the function in a loop
sentences=data_frame(stringsAsFactors=FALSE)
for (i in 1:nrow(filteredTokenRows)){ #simply passing 1-n where n is however many matches
  sentences = rbind(sentences, as.character(GetSentences(i)))
}

#### sink sentences to matchSentences.txt ####
tempDir=file("../output/matchSentences.txt")
sink(tempDir)
writeLines(unlist(sentences))
sink()

#### sentimentAnalysis ####
#get and set sentiment vars
sentiment = analyzeSentiment(unlist(sentences))
sentimentDirection = convertToDirection(sentiment)

#output text to sentimentDirections.txt
#sentimentFrame$sentence = stringMatchResult
thumbsUp = toString("<i class='fa fa-thumbs-up' style='color:green'></i>")
neutralIcon = toString("<i class='fa fa-star-half-o' style='color:orange'></i>")
thumbsDown = toString("<i class='fa fa-thumbs-o-down' style='color:red'></i>")

tempDir=file("../output/sentimentDirections.txt")
sink(tempDir)


for (i in 2:nrow(sentences)){
  writeLines(paste(sentences$stringsAsFactors[i],
                   "</div><div class='w3-rest w3-cell-middle w3-right w3-padding w3-hover-pale-blue'>",
                   "GI: ",str_replace_all(sentimentDirection$SentimentGI[i],c("positive"=thumbsUp, "neutral"=neutralIcon, "negative"=thumbsDown)),"<br>",
                   "HE: ",str_replace_all(sentimentDirection$SentimentHE[i],c("positive"=thumbsUp, "neutral"=neutralIcon, "negative"=thumbsDown)),"<br>",
                   "LM: ",str_replace_all(sentimentDirection$SentimentLM[i],c("positive"=thumbsUp, "neutral"=neutralIcon, "negative"=thumbsDown)),"<br>",
                   "QDAP: ",str_replace_all(sentimentDirection$SentimentQDAP[i],c("positive"=thumbsUp, "neutral"=neutralIcon, "negative"=thumbsDown))))
}
sink()

#output png to sentimentMatchChart.png
png("../output/sentimentMatchChart.png", width=600, height=300)
plotSentiment(sentiment, xlab="word occurrences") + ggtitle("Sentiment by word-occurrence")
dev.off()
