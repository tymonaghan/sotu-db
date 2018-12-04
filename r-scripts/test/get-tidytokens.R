#WHAT THIS SCRIPT DOES
# INPUT: all files in working directory
    # use REGEX to extract info from filenames and create tidy tibble
# OUTPUT "tidytokens" tidy text tibble, with tokens, filenames, years, presidents, political parties

#WHAT THIS SCRIPT DOES NOT DO
#any sentiment analysis, 
#does not remove punctuation - wait yes it does!

#Be sure to setwd as speeches-ucsb-pres-project
#setwd("/home/manager/git/sotu-db/speeches-ucsb-pres-project")
setwd("C:/Users/tnmon/git/sotu-db/speeches-sample")

library(tidyverse)
library(tidytext)
library(glue)
library(stringr)
library(tm)
library(dplyr)


files <- list.files("./") # get a list of the files in the input directory
#files <- SOTUs4 # get a list of the documents in SOTUs4

#toDollars = content_transformer(function(x,pattern) {return (gsub(pattern, "dollars ", x))}) #use toDollars to change dollar signs to "dollars"
tidytokens = data_frame() #make the tidytokens data_frame (empty for now)

#my transformations:
for(i in files){
fileText = tm_map(fileText, toDollars, "\\$") #replace $ with "dollars"
#fileText = tm_map(fileText, removePunctuation)  #remove punctuation
#fileText = tm_map(fileText,content_transformer(tolower)) #Transform to lower case (need to wrap in content_transformer)
} 

GetTidy = function(file) {
  
  fileName <- glue("./", file, sep = "")
  fileName <- trimws(fileName)   # get rid of any whitespace
  fileText <- glue(read_file(fileName))  # read in the new file
  #fileText <- read_file(file)  # read in the new file
  # tokenize
  tokens <- data_frame(text = fileText) %>% unnest_tokens(word, text, to_lower=FALSE)
  
  tidytokens <- tokens %>%
    #group_by(president) %>%
    mutate(file = file) %>% # add the name of our file
    mutate(year = as.numeric(str_match(file, "\\d{4}"))) %>% # add the year
    mutate(linenumber = row_number()) %>% #line number currently is just one "line" per token but at least it gives its position within the SOTU
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
  tidytokens = rbind(tidytokens, GetTidy(i))
}