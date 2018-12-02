library(tidyverse)
library(tidytext)
library(glue)
library(stringr)

lines <- readLines(con = file('../speeches-ucsb-pres-project/2012-01-24-obama.md'))
lineCount <- length(lines)

tokens <- data_frame(text = lines) %>% unnest_tokens(word, text)

tokens %>%
  inner_join(get_sentiments("bing")) %>%
  count(sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)
