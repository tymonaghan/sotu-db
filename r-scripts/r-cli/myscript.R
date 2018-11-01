library(tidyverse)
library(tidytext)
library(glue)
library(stringr)

lines <- readLines(con = file("stdin"))
lineCount <- length(lines)
lines %>%
  inner_join(get_sentiments("bing")) %>%
  count(sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)
