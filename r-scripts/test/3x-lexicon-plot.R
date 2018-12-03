#### environment prerequisites ####
# must have already created tidytokens tibble

#### handle input arguments ####
args = commandArgs(trailingOnly=FALSE)
# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} 

yearToSearch = args[1]

#### load packages ####
#not needed if tidyverse is already loaded:
library(dplyr)
library(stringr)
library(ggplot2)
yearToSearch

#### select year and chunk size ####
#yearToSearch = 1793
chunkSize = 65
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