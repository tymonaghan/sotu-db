# https://www.kaggle.com/rtatman/tutorial-sentiment-analysis-in-r
# load in the libraries we'll need
library(tidyverse)
library(tidytext)
library(glue)
library(stringr)

# get a list of the files in the input directory
files <- list.files("~/git/sotu-db/speeches-gutenberg")

# stick together the path to the file & 1st file name
fileName <- glue("~/git/sotu-db/speeches-gutenberg/", files[1], sep = "")

# get rid of any sneaky trailing spaces
fileName <- trimws(fileName)

# read in the new file
fileText <- glue(read_file(fileName))

#inspect a particular document
writeLines(as.character(fileText))

# remove any dollar signs (they're special characters in R)
fileText <- gsub("\\$", "", fileText) 

# tokenize
tokens <- data_frame(text = fileText) %>% unnest_tokens(word, text)
## this %>% thing is blowing my mind, should figure out what that's doing.

# get the sentiment from the first text: 
tokens %>%
  inner_join(get_sentiments("bing")) %>% # pull out only sentiment words
  count(sentiment) %>% # count the # of positive & negative words
  spread(sentiment, n, fill = 0) %>% # made data wide rather than narrow (what?)
  mutate(sentiment = positive - negative) # # of positive words - # of negative words
#holy shit that was easy, thanks Bing Liu and co-authors: https://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html

# Now that we know how to get the sentiment for a given text, let's write a function to do this more quickly and easily and then apply that function to every text in our dataset.
# write a function that takes the name of a file and returns the # of postive
# sentiment words, negative sentiment words, the difference & the normalized difference
GetSentiment = function(file){
  # get the file
  fileName <- glue("~/git/sotu-db/speeches-gutenberg/", file, sep = "")
  # get rid of any sneaky trailing spaces
  fileName <- trimws(fileName)
  
  # read in the new file
  fileText <- glue(read_file(fileName))
  # remove any dollar signs (they're special characters in R)
  fileText <- gsub("\\$", "", fileText) 
  
  # tokenize
  tokens <- data_frame(text = fileText) %>% unnest_tokens(word, text)
  
  # get the sentiment from the first text: 
  sentiment <- tokens %>%
    inner_join(get_sentiments("bing")) %>% # pull out only sentimen words
    count(sentiment) %>% # count the # of positive & negative words
    spread(sentiment, n, fill = 0) %>% # made data wide rather than narrow
    mutate(sentiment = positive - negative) %>% # # of positive words - # of negative owrds

    
    mutate(file = file) %>% # add the name of our file
    mutate(year = as.numeric(str_match(file, "\\d{4}"))) %>% # add the year
    #i think this is just looking for 4 digits in a row
    
    #mutate(president = str_match(file, "(.*?)_")[2]) # add president
    #this is based on a file name structure of Adams_1797.txt so I should be able to figure out how to change it up...
    mutate(president = str_match(file, "(?<=-)[A-z]+(?=-)")) #this is just pulling text strings 4+ chars long right noiw, which i guess works...
  
    
    
  # return our sentiment dataframe
  return(sentiment)
}

# test: should return
# negative	positive	sentiment	file	        year	president
# 117	      240	      123	      Bush_1989.txt	1989	Bush
GetSentiment(files[197]) 
# i am still sort of perplexed about how it is numbering these but this worked for now

#inspect a particular document
writeLines(as.character(files))

# file to put our output in
sentiments <- data_frame()

positive=0
negative=0

# get the sentiments for each file in our datset
for(i in files){
  sentiments <- rbind(sentiments, GetSentiment(i))
}

#inspect a particular document
writeLines(as.character(sentiments))

# disambiguate Bush Sr. and George W. Bush 
# correct president in applicable rows
bushSr <- sentiments %>% 
  filter(president == "Bush") %>% # get rows where the president is named "Bush"...
  filter(year < 2000) %>% # ...and the year is before 200
  mutate(president = "Bush Sr.") # and change "Bush" to "Bush Sr."

# remove incorrect rows
sentiments <- anti_join(sentiments, sentiments[sentiments$president == "Bush" & sentiments$year < 2000, ])

# add corrected rows to data_frame 
sentiments <- full_join(sentiments, bushSr)

# summarize the sentiment measures
summary(sentiments)


####################
## VISUALIZATIONS ##
####################
# plot of sentiment over time & automatically choose a method to model the change
ggplot(sentiments, aes(x = as.numeric(year), y = sentiment)) + 
  geom_point(aes(color = president))+ # add points to our plot, color-coded by president
  geom_smooth(method = "auto") # pick a method & fit a model
#haha these colors are messed up but it's cool lookin'. will have to dig into this code to see what it's doing with the colors.

# plot of sentiment by president
ggplot(sentiments, aes(x = president, y = sentiment, color = president)) + 
  geom_boxplot() # draw a boxplot for each president
#curious about why some of these don't appear as boxes (or maybe the dot just doesn't overlap the box somehow?)  

