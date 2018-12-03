#### handle input arguments ####
args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  message("using searchterm: " , toString(args[1]))
}

userQuery = toString(args[1])


#### load packages ####
library(stringr)
library(glue)
load("../r-env/tidytokens-sample.RData")

#### set REGEX versions of query ####

regexUserQuery = paste0("(?i)",userQuery)
regexUserQuerySentence = paste0("[^.]*",regexUserQuery,"[^.]*\\.")
#### print to screen to debug ####
#userQuery
#regexUserQuery
#regexUserQuerySentence

#### count ####
stringCountResult = str_count(clearText1989, regexUserQuery)
stringCountSum = sum(stringCountResult)
lapply(stringCountSum, write, "../output/test11.txt", append=FALSE)

#### sentences to test22.txt ####
stringMatchResult= str_match_all(clearText1989, regexUserQuerySentence)
stringMatchResult = stringMatchResult[lapply(stringMatchResult,length)>0]
tempDir=file("../output/test22.txt")
sink(tempDir)
writeLines(unlist(lapply(stringMatchResult, paste, collapse=" ")))
sink()
