#### handle input arguments ####
arguments = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(arguments)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(arguments)==1) {
  # default chunk size
  arguments[2] = as.integer(80)
}

yearToSearch = arguments[1]
chunkSize = as.integer(arguments[2])
positive = 0
negative = 0


#Be sure to setwd as speeches-ucsb-pres-project
#setwd("/home/manager/git/sotu-db/speeches-ucsb-pres-project")
setwd("C:/Users/tnmon/git/sotu-db/speeches-ucsb-pres-project")

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
#for(i in files){
#fileText = tm_map(fileText, toDollars, "\\$") #replace $ with "dollars"
#fileText = tm_map(fileText, removePunctuation)  #remove punctuation
#fileText = tm_map(fileText,content_transformer(tolower)) #Transform to lower case (need to wrap in content_transformer)
#} 

GetTidy = function(file) {
  
  fileName <- glue("./", file, sep = "")
  fileName <- trimws(fileName)   # get rid of any whitespace
  fileText <- glue(read_file(fileName))  # read in the new file
  #fileText <- read_file(file)  # read in the new file
  # tokenize
  tokens <- data_frame(text = fileText) %>% unnest_tokens(word, text)
  
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
  tidytokens = rbind(tidytokens, GetTidy(i))
}

#### environment prerequisites ####
# must have already created tidytokens tibble



#### load packages ####
#not needed if tidyverse is already loaded:
library(dplyr)
library(stringr)
library(ggplot2)
yearToSearch

#### select year and chunk size ####
#yearToSearch = 1793
#chunkSize = 65
singleSOTU <- tidytokens %>% filter(year == yearToSearch)

# Lets again use integer division (%/%) to define larger sections of text that
# span multiple lines, and we can use the same pattern with count(), spread(),
# and mutate() to find the net sentiment in each of these sections of text.

afinn = singleSOTU %>% 
  inner_join(get_sentiments("afinn")) %>% 
  group_by(index = linenumber%/%chunkSize) %>% 
  summarise(sentiment = sum(score)) %>% 
  mutate(method = "AFINN")

bing_and_nrc = bind_rows(singleSOTU %>% inner_join(get_sentiments("bing")) %>% 
                           mutate(method = "Bing et al."), singleSOTU %>% 
                           inner_join(get_sentiments("nrc") %>%
                                        filter(sentiment %in% c("positive", "negative"))) %>% 
                           mutate(method = "NRC")) %>% 
  count(method, index = linenumber%/%chunkSize, sentiment) %>% 
  spread(sentiment, n, fill = 0) %>% 
  mutate(sentiment = positive - negative)

#### bind and visualize ####

#output to png?
png("../temp-samples/3x-lexicon-plot.png")
bind_rows(afinn, bing_and_nrc) %>% 
  ggplot(aes(index, sentiment, fill = method)) + 
  geom_col(show.legend = FALSE) + 
  facet_wrap(~method, ncol = 1, scales = "free_y")+
  ggtitle(paste("Comparison of sentiment with 3 lexicons for", yearToSearch, "\nChunk size:",chunkSize, "words"))
dev.off()