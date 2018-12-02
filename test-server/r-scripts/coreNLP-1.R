#### handle input arguments ####
args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  print("only one argument specified - using default chunk size of 65 words")
  args[2]= as.integer(65)
} else {
  message("using year: " , args[1] , "\nusing chunk size:" , args[2])
}
userQuery = toString(args[1])
chunkSize = as.integer(args[2])
plainTextSOTU = readLines("../speeches-sample/2013-02-12-obama.md")
plainTextSOTU = gsub("\\$", "dollars", plainTextSOTU)


#### load packages  and workspace ####
library(tidyverse)
library(tidytext)
library(glue)
library(stringr)
library(tm)
library(coreNLP)
load("../r-env/tidytokens-sample.RData")

#### invoke coreNLP pipeline: pos, sentiment ####
initCoreNLP()

#### debug defaults ####
#userQuery = toString("together")
#chunkSize = 65
#yearSearched=2013
#singleSOTU <- tidytokens %>% filter(year == yearSearched)
regexUserQuery = paste0("(?i)",userQuery)
regexUserQuerySentence = paste0("[^.]*",regexUserQuery,"[^.]*\\.")
#coreNLPtokens = getToken(annotationByCoreNLP)
#sentiment = getSentiment(annotationByCoreNLP)
userQuery
regexUserQuery
regexUserQuerySentence

#### ? ####
#matches = coreNLPtokens %>%
#  str_match_all(userQuery)

#### str_count(x,pattern) ####
#case sensitive:
#str_count(plainTextSOTU, userQuery)
#sink()
#sink()
#case insensitive:
stringCountResult = str_count(plainTextSOTU, regexUserQuery)
stringCountSum = sum(stringCountResult)
lapply(glue("your term appears this many times: ",stringCountSum), write, "../output/test.txt", append=FALSE)


#### str_subset(x,pattern) ####
#str_subset(plainTextSOTU, "")
#WTF

#### str_locate(x,pattern) ####
stringLocateResult = str_locate_all(plainTextSOTU, regexUserQuery)

#### str_extract(x,pattern) ####
stringExtractResults=str_extract_all(plainTextSOTU,regexUserQuery)
stringExtractResultSimplified = str_extract_all(plainTextSOTU,regexUserQuery, simplify=TRUE)

#### str_match_all(x,pattern) ####
#this creates a list of 185, and the populated cells are the sentences with the users search word in them.
stringMatchResult= str_match_all(plainTextSOTU, regexUserQuerySentence)
stringMatchResult = stringMatchResult[lapply(stringMatchResult,length)>0]

for (index in length(stringMatchResult)){
  lapply(index, write, "../output/test.txt", append=TRUE)

}

lapply(stringMatchResult, write, "../output/test2.txt", append=FALSE)
tempDir=file("../output/test3.txt")
sink(tempDir)
writeLines(unlist(lapply(stringMatchResult, paste, collapse=" ")))
sink()
#DOLLAR SIGNS preventing all the sentences from writing correctly.
#stringMatchResultMatrix= rownames(stringMatchResult, 1:length(stringMatchResult))
