# WHAT THIS SCRIPT DOES INPUT: tidytokens tibble

# OUTPUT: tidySOTUs tibble (adds 'linenumber' which counts tokens per document
# ggplot visualization of sentiment throughout each document wordcloud and
# color-coded wordcloud of sentiments in a particular document

# adapted from https://www.tidytextmining.com/sentiment.html

#### load libraries ####
library(dplyr)
library(stringr)
library(ggplot2)
library(tidyr)


# set NRC lexicon and filter() for the joy words.
nrc_joy <- get_sentiments("nrc") %>% filter(sentiment == "joy")

# filter() the data frame:
# "file" which file to use
# use inner_join() with the nrc_joy list from the prev. step to perform the sentiment analysis.
# use count() from dplyr.
tidytokens %>% 
  filter(file == "11-06-1792-washington.md") %>% 
  inner_join(nrc_joy) %>% 
  count(word, sort = TRUE)


SOTU_sentiment <- tidytokens %>% 
  inner_join(get_sentiments("bing")) %>% 
  count(file, index = linenumber%/%80, sentiment) %>% 
  spread(sentiment, n, fill = 0) %>% 
  mutate(sentiment = positive - negative)

# Now we can plot these sentiment scores across the plot trajectory of each
# novel. Notice that we are plotting against the index on the x-axis that keeps
# track of narrative time in sections of text.
ggplot(SOTU_sentiment, aes(index, sentiment, fill = file)) + geom_col(show.legend = FALSE) + 
  facet_wrap(~file, ncol = 10, scales = "free_x")

#### lexicon vs lexicon comps per SOTU ####
# use all three sentiment lexicons and examine how the sentiment changes
# use filter() to choose only the words from the SOTU we want
# right now we are filtering by year
yearToSearch = 1793
singleSOTU <- tidytokens %>% filter(year == yearToSearch)

# Lets again use integer division (%/%) to define larger sections of text that
# span multiple lines, and we can use the same pattern with count(), spread(),
# and mutate() to find the net sentiment in each of these sections of text.

afinn <- singleSOTU %>% inner_join(get_sentiments("afinn")) %>% group_by(index = linenumber%/%80) %>% 
  summarise(sentiment = sum(score)) %>% mutate(method = "AFINN")

bing_and_nrc <- bind_rows(singleSOTU %>% inner_join(get_sentiments("bing")) %>% 
                            mutate(method = "Bing et al."), singleSOTU %>% 
                            inner_join(get_sentiments("nrc") %>%
                            filter(sentiment %in% c("positive", "negative"))) %>% 
                            mutate(method = "NRC")) %>% 
                            count(method, index = linenumber%/%80, sentiment) %>% 
                            spread(sentiment, n, fill = 0) %>% 
                            mutate(sentiment = positive - negative)


# We now have an estimate of the net sentiment (positive - negative) in each chunk of the SOTU text for each sentiment lexicon. 
# Let's bind them together and visualize them:

bind_rows(afinn, bing_and_nrc) %>% 
  ggplot(aes(index, sentiment, fill = method)) + 
  geom_col(show.legend = FALSE) + 
  facet_wrap(~method, ncol = 1, scales = "free_y")+
  ggtitle(paste("Comparison of sentiment with 3 lexicons for", yearToSearch))


# Why is, for example, the result for the NRC lexicon biased so high in sentiment
# compared to the Bing et al. result? Let's look briefly at how many positive
# and negative words are in these lexicons.

# get counts for nrc
get_sentiments("nrc") %>% 
  filter(sentiment %in% c("positive", "negative")) %>% 
  count(sentiment)

# get counts for bing
get_sentiments("bing") %>% 
  count(sentiment)

# One advantage of having the data frame with both sentiment and word is that we
# can analyze word counts that contribute to each sentiment. By implementing
# count() here with arguments of both word and sentiment, we find out how much
# each word contributed to each sentiment.

bing_word_counts <- tidy_SOTUs %>% inner_join(get_sentiments("bing")) %>% count(word, 
                                                                                sentiment, sort = TRUE) %>% ungroup()

bing_word_counts


# This can be shown visually, and we can pipe straight into ggplot2, if we like,
# because of the way we are consistently using tools built for handling tidy data
# frames.

bing_word_counts %>% group_by(sentiment) %>% top_n(10) %>% ungroup() %>% mutate(word = reorder(word, 
                                                                                               n)) %>% ggplot(aes(word, n, fill = sentiment)) + geom_col(show.legend = FALSE) + 
  facet_wrap(~sentiment, scales = "free_y") + labs(y = "Contribution to sentiment", 
                                                   x = NULL) + coord_flip()



# wordcloud:
library(wordcloud)
tidy_SOTUs %>% anti_join(stop_words) %>% count(word) %>% with(wordcloud(word, n, 
                                                                        max.words = 80))

# Let's do the sentiment analysis to tag positive and negative words using an
# inner join, then find the most common positive and negative words. Until the
# step where we need to send the data to comparison.cloud(), this can all be done
# with joins, piping, and dplyr because our data is in tidy format.

library(reshape2)
# color-coded pos-neg wordcloud
tidy_SOTUs %>% inner_join(get_sentiments("bing")) %>% count(word, sentiment, sort = TRUE) %>% 
  acast(word ~ sentiment, value.var = "n", fill = 0) %>% comparison.cloud(colors = c("red", 
                                                                                     "blue"), max.words = 50)