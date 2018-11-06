library(tidyverse)
library(tidytext)
library(glue)
library(stringr)

lines <- readLines(con = file("./sample-texts/1790-01-08-washington.md"))
lineCount <- length(lines)

tokens <- data_frame(text = lines) %>% unnest_tokens(word, text)

tokens %>%
  inner_join(get_sentiments("bing")) %>%
  count(sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)
