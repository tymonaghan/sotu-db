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

yearSearched = as.integer(args[1])
chunkSize = as.integer(args[2])
positive = 0
negative = 0
#### defaults ####
#yearSearched = 2013
#chunkSize=69

#### load packages and environment ####
library(tidyverse)
library(tidytext)
library(stringr)
library(tm)
library(dplyr)
library(ggplot2)
load("../r-env/tidytokens-sample.RData")

#### create singleSOTU from yearSearched ####
singleSOTU <- tidytokens %>% filter(year == yearSearched)

#### find sent-scores for afinn, bing, nrc ####
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
#output to png
png("../output/plot.png")

bind_rows(afinn, bing_and_nrc) %>%
  ggplot(aes(index, sentiment, fill = method)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~method, ncol = 1, scales = "free_y")+
  ggtitle(paste("Comparison of sentiment with 3 lexicons for", yearSearched, "\nChunk size:",chunkSize, "words"))
dev.off()

#### write SOTU to stdout ####
writeLines(as.character(singleSOTU[[1]]))
