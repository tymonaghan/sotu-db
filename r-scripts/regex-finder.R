#### handle input arguments ####
args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  message("using searchterm: " , toString(args[1]))
}

userQuery = toString(args[1])
plainTextSOTU = readLines("../speeches-sample/1989-02-09-bush.md")
plainTextSOTU = gsub("\\$", "dollars", plainTextSOTU)

library(stringr)
library(glue)


regexUserQuery = paste0("(?i)",userQuery)
regexUserQuerySentence = paste0("[^.]*",regexUserQuery,"[^.]*\\.")
userQuery
regexUserQuery
regexUserQuerySentence

stringCountResult = str_count(plainTextSOTU, regexUserQuery)
stringCountSum = sum(stringCountResult)
lapply(glue("your term appears this many times: ",stringCountSum), write, "../output/test11.txt", append=FALSE)

stringMatchResult= str_match_all(plainTextSOTU, regexUserQuerySentence)
stringMatchResult = stringMatchResult[lapply(stringMatchResult,length)>0]
tempDir=file("../output/test22.txt")
sink(tempDir)
writeLines(unlist(lapply(stringMatchResult, paste, collapse=" ")))
sink()