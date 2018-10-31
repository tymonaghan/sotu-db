###DEPRECATED _ CAN DELETE
# WHAT THIS SCRIPT DOES:
  # takes the files in the working directory, performs the following transformations:
    # replace "$" with "dollars"
    # remove punctuation
    # convert to all lowercase
# OUTPUT: "SOTUs4" SimpleCorpus

#load the text mining library
library(tm)
#create corpus
SOTUs = Corpus(DirSource("./"))
#see some info about the SOTUs corpus
SOTUs
#inspect a particular document
writeLines(as.character(SOTUs[[1]]))
#RYO: build content transformer to swap $ for "dollars"
toDollars = content_transformer(function(x,pattern) {return (gsub(pattern, "dollars ", x))})
#use toDollars to change dollar signs to "dollars"
SOTUs2 = tm_map(SOTUs, toDollars, "\\$")
#inspect a particular document
writeLines(as.character(SOTUs2[[5]]))
#turns out there's already a function to remove punctuation built into tm:
SOTUs3 = tm_map(SOTUs2, removePunctuation)
#Transform to lower case (need to wrap in content_transformer)
SOTUs4 = tm_map(SOTUs3,content_transformer(tolower))
# SOTUs 4 is the final corpus