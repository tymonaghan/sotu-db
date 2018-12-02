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
#userQuery = args[1]
#chunkSize = as.integer(args[2])

#### load packages  and workspace ####
library(tidyverse)
library(tidytext)
library(glue)
library(stringr)
library(tm)
library(coreNLP)
load("../r-env/tidytokens-sample.RData")
annotationByCoreNLP = annotateFile("../speeches-sample/2013-02-12-obama.md")

plainTextSOTU = readLines("../speeches-sample/2013-02-12-obama.md")

#annotationByCoreNLP = annotateString(textString)

#### invoke coreNLP pipeline: pos, sentiment ####
initCoreNLP()

#### debug defaults ####
textString = "If we work together, we can make some big farts. Together, anything is possible, together."
userQuery = toString("together")
chunkSize = 65
#yearSearched=2013
#singleSOTU <- tidytokens %>% filter(year == yearSearched)

regexUserQuery = paste0("(?i)",userQuery)
regexUserQuerySentence = paste0("[^.]*",regexUserQuery,"[^.]*\\.")



coreNLPtokens = getToken(annotationByCoreNLP)
sentiment = getSentiment(annotationByCoreNLP)

#### ? ####
matches = coreNLPtokens %>%
  str_match_all(userQuery)

#### str_count(x,pattern) ####
#case sensitive:
str_count(textString, userQuery)

#case insensitive:
str_count(textString, regexUserQuery)
str_count(singleSOTU[1], regexUserQuery)

stringCountResult = str_count(textString, regexUserQuery)


#### str_subset(x,pattern) ####
str_subset(textString, "") 
WTF

#### str_locate(x,pattern) ####
stringLocateResult = str_locate_all(textString, regexUserQuery)

#### str_extract(x,pattern) ####
stringExtractResults=str_extract_all(textString,regexUserQuery)
stringExtractResultSimplified = str_extract_all(textString,regexUserQuery, simplify=TRUE)

#### str_match_all(x,pattern) ####
stringMatchResult= str_match_all(textString, regexUserQuerySentence)

str_match_all(,regexUserQuerySentence)
