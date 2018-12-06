####packages####
library(tidyverse)
library(tidytext)
library(glue)
library(stringr)
library(tm)
library(dplyr)
library(coreNLP)
initCoreNLP()


#### vars and aliases ####
#icons for up-down-neutral sentiment:
iconThumbsUp = toString("<i class='fa fa-thumbs-up' style='color:green'></i>")
iconHalfStar = toString("<i class='fa fa-star-half-o' style='color:orange'></i>")
iconThumbsDown = toString("<i class='fa fa-thumbs-o-down' style='color:red'></i>")


#### generate tidyWords ####
files = list.files("../speeches-sample/") # get a list of the files in the input directory
tidyWords = data_frame() #make the tidySentences data_frame (empty for now)

GetTidyWords = function(file) {
  
  fileName <- glue("../speeches-sample/", file, sep = "")
  fileName <- trimws(fileName)   # get rid of any whitespace
  fileText <- glue(read_file(fileName))  # read in the new file
  #fileText <- read_file(file)  # read in the new file
  # tokenize
  tokens <- data_frame(text = fileText) %>% unnest_tokens(word, text, token="words",to_lower=FALSE)
  
  tidytokens <- tokens %>%
    #group_by(president) %>%
    mutate(file = file) %>% # add the name of our file
    mutate(year = as.numeric(str_match(file, "\\d{4}"))) %>% # add the year
    mutate(wordNumber = row_number()) %>% #line number currently is just one "line" per token but at least it gives its position within the SOTU
    # REGEX for yyyy-Potusname-m-d.txt, uncomment to use: 
    # mutate(president = str_match(file, "(?<=-)[A-z]+(?=-)")) %>% #thanks @RJP43 for helping with this REGEX
    # REGEX for mm-dd-yyyy-potusname.md
    mutate(president = str_match(file, "(?<=-)[A-z]+(?=.md)")) #%>%
  
  #never figured out how to do this without encoding directly in the filename.
  #ultimately i want to be able to read from the master index file.
  #perhaps reading that file into R and writing it as variables, then performing these tasks with those variables would work.
  #mutate(party = str_match(file, "[A-z](?=[.])"))
  
  # return our tidytokens dataframe
  return(tidytokens)
}

for(i in files){
  #do it in a loop and each time append rows (rbind)
  tidyWords = rbind(tidyWords, GetTidyWords(i))
}


#### generate tidySentences ####
files = list.files("../speeches-sample/") # get a list of the files in the input directory
tidySentences = data_frame() #make the tidySentences data_frame (empty for now)

GetTidySentences = function(file) {
  
  fileName <- glue("../speeches-sample/", file, sep = "")
  fileName <- trimws(fileName)   # get rid of any whitespace
  fileText <- glue(read_file(fileName))  # read in the new file
  #fileText <- read_file(file)  # read in the new file
  # tokenize
  tokens <- data_frame(text = fileText) %>% unnest_tokens(word, text, token="sentences",to_lower=FALSE)
  
  tidytokens <- tokens %>%
    #group_by(president) %>%
    mutate(file = file) %>% # add the name of our file
    mutate(year = as.numeric(str_match(file, "\\d{4}"))) %>% # add the year
    mutate(sentenceNumber = row_number()) %>% #line number currently is just one "line" per token but at least it gives its position within the SOTU
    # REGEX for yyyy-Potusname-m-d.txt, uncomment to use: 
    # mutate(president = str_match(file, "(?<=-)[A-z]+(?=-)")) %>% #thanks @RJP43 for helping with this REGEX
    # REGEX for mm-dd-yyyy-potusname.md
    mutate(president = str_match(file, "(?<=-)[A-z]+(?=.md)")) #%>%
  
  #never figured out how to do this without encoding directly in the filename.
  #ultimately i want to be able to read from the master index file.
  #perhaps reading that file into R and writing it as variables, then performing these tasks with those variables would work.
  #mutate(party = str_match(file, "[A-z](?=[.])"))
  
  # return our tidytokens dataframe
  return(tidytokens)
}

for(i in files){
  #do it in a loop and each time append rows (rbind)
  tidySentences = rbind(tidySentences, GetTidySentences(i))
}



#### functions ####
GetAnnotation = function(file){
  annotated = annotateFile(file)
  return(annotated)
}

GetAnnotatedTokens = function(annotatedFile){
  tokens = getToken(annotatedFile)
  return(tokens)
}

GetClearText = function(file){
  clearText = readLines(file)
  return(clearText)
}

####generate environment ####
files = list.files("../speeches-sample/") # get a list of the files in the input directory


#### save environment ####
save("../r-env/sample-env.R")







sprintf("%s", 1:length(files))











for (i in files){
  fileName = paste0("../speeches-sample/",file)
  annotations[i]= annotateFile(fileName)
}
file = files[1]
filePath = "../speeches-sample/small/"
fileName = paste0(filePath,file)
paste0("annotated-",file) = annotateFile(fileName)


clearText1989 = readLines("../speeches-sample/1989-02-09-bush.md")
clearText1989 = gsub("\\$", "dollars ", clearText1989)
