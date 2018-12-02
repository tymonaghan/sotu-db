# https://www.kaggle.com/rtatman/tutorial-sentiment-analysis-in-r
# load in the libraries we'll need
library(tidyverse)
library(tidytext)
library(glue)
library(stringr)

# get a list of the files in the input directory
files <- list.files("/home/manager/git/sotu-db/speeches-gutenberg")

# stick together the path to the file & 1st file name
fileName <- glue("/home/manager/git/sotu-db/speeches-gutenberg/", files[1], sep = "")

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

nrow(tokens)


# Now that we know how to get the sentiment for a given text, let's write a function to do this more quickly and easily and then apply that function to every text in our dataset.
# write a function that takes the name of a file and returns the # of postive
# sentiment words, negative sentiment words, the difference & the normalized difference
GetSentiment = function(file){
  # get the file
  fileName <- glue("/home/manager/git/sotu-db/speeches-gutenberg/", file, sep = "")
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
    mutate(sentiment = positive - negative) %>% # # of positive words - # of negative words
    
    mutate(normalSentiment = sentiment/nrow(tokens)) %>%

    
    mutate(file = file) %>% # add the name of our file
    mutate(year = as.numeric(str_match(file, "\\d{4}"))) %>% # add the year
    #i think this is just looking for 4 digits in a row
    
    #mutate(president = str_match(file, "(.*?)_")[2]) # add president
    #this is based on a file name structure of Adams_1797.txt so I should be able to figure out how to change it up...
    mutate(president = str_match(file, "(?<=-)[A-z]+(?=-)")) %>% #thanks @RJP43 for helping with this REGEX
    mutate(party = str_match(file, "[A-z](?=[.])"))
  
    
    
  # return our sentiment dataframe
  return(sentiment)
}

# test: should return
# negative	positive	sentiment	file	        year	president
# 117	      240	      123	      Bush_1989.txt	1989	Bush
GetSentiment(files[200]) 
# i am still sort of perplexed about how it is numbering these but this worked for now

#inspect a particular document
writeLines(as.character(files))

# file to put our output in
sentiments <- data_frame()

tidy_test_frame = data_frame()

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
# bushSr <- sentiments %>% 
#  filter(president == "Bush") %>% # get rows where the president is named "Bush"...
#  filter(year < 2000) %>% # ...and the year is before 200
#  mutate(president = "Bush Sr.") # and change "Bush" to "Bush Sr."

# remove incorrect rows
# sentiments <- anti_join(sentiments, sentiments[sentiments$president == "Bush" & sentiments$year < 2000, ])

# add corrected rows to data_frame 
# sentiments <- full_join(sentiments, bushSr)

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
#oh i see, the colors are just assigned alphabetircally but they are plotted by year.

# plot of NORMALIZED BY WORD COUNT sentiment over time & automatically choose a method to model the change
ggplot(sentiments, aes(x = as.numeric(year), y = normalSentiment)) + 
  geom_point(aes(color = president))+ # add points to our plot, color-coded by president
  geom_smooth(method = "auto") # pick a method & fit a model

# plot of sentiment by president
ggplot(sentiments, aes(x = president, y = sentiment, color = president)) + 
  geom_boxplot() # draw a boxplot for each president
 #curious about why some of these don't appear as boxes (or maybe the dot just doesn't overlap the box somehow?)  

# plot of sentiment by president
ggplot(sentiments, aes(x = president, y = normalSentiment, color = president)) + 
  geom_boxplot() # draw a boxplot for each president


# is the difference between parties significant?
# get democratic presidents & add party affiliation
democrats=0
#ok I think I am going to have to do this "per-potus" since the list matching thing isn't working.
democrats = sentiments %>%
  filter(president == c("Jackson", "Polk")) %>%
  mutate(party = "D")

democrats = sentiments %>%
  filter(president == "vanBuren") %>%
  mutate(party = "D")

democrats = sentiments %>%
  filter(president == "Polk") %>%
  mutate(party = "D")
#ok this isn't working either, it's overwriting not appending. gonna try this stupid solution of just embedding party into the filenames.


democrats2 = sentiments %>%
  filter(president == c("Pierce", "Buchanan", "Johnson", "Cleveland","Wilson")) %>%
  mutate(party = "D")

democrats3 = sentiments %>%
  filter(president == c("FDR","Truman","Kennedy","LBJ","Carter")) %>%
  mutate(party = "D")

# get republican presidents & party add affiliation
republicans = sentiments %>%
  filter(president == c("Lincoln","Grant","Hayes","Garfield","Arthur","Harrison","McKinley","TRoosevelt","Taft","Harding","Coolidge","Hoover","Eisenhower","Nixon","Ford","Reagan","HWBush","WBush","Trump")) %>%
  mutate(party = "R")
# i'm not understanding why there's an error here. it doesn't seem necessary to define the length of "republicans" anywhere, why is it defining 5 as the maximum length?

democrats = sentiments %>%
  filter(party == "d") %>%
  mutate(party = "Democratic")

republicans = sentiments %>%
  filter(party == "r") %>%
  mutate(party = "Republican")

whigs = sentiments %>%
  filter(party == "w") %>%
  mutate(party = "Whig")

demRepublicans = sentiments %>%
  filter(party == "c") %>%
  mutate(party = "Democratic-Republican")

federalists = sentiments %>%
  filter(party == "f") %>%
  mutate(party = "Federalist")

unafilliated = sentiments %>%
  filter(party == "u") %>%
  mutate(party = "Unaffiliated")

summary(democrats)
writeLines(as.character(democrats))

summary(republicans)
writeLines(as.character(republicans))

#join dems
# byDems = full_join(democrats, democrats2, democrats3)
#not using 

# join both
byParty <- full_join(democrats, republicans)

wAndF = full_join(whigs,federalists)

cAndU = full_join(demRepublicans, unafilliated)

join1 = full_join(byParty, wAndF)

join2 = full_join(join1, cAndU)

# the difference between the parties is significant
t.test(democrats$sentiment, republicans$sentiment)

# plot sentiment by party
ggplot(join2, aes(x = party, y = sentiment, color = party)) + geom_boxplot() + geom_point()
# this is not working right when generating the democrat and republican lists - need to investigate.

ggplot(join2, aes(x = party, y = normalSentiment, color = party)) + geom_boxplot() + geom_point()

ggplot(byParty, aes(x = party, y = normalSentiment, color = party)) + geom_boxplot() + geom_point()
