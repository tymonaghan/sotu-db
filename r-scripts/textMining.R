#######################
## ENVIRONMENT SETUP ##
#######################

#get working directory
getwd()

#set working directory
setwd("~/git/sotu-db/speeches-gutenberg")

#load the text mining library
library(tm)

#create corpus
SOTUs = Corpus(DirSource("~/git/sotu-db/speeches-gutenberg"))
#there has to be a way to just say "working directory..."
# can use = or <- for assignment

#see some info about the SOTUs corpus
SOTUs

#inspect a particular document
writeLines(as.character(SOTUs[[1]]))
#^ prints contents of document 1 in console -- THERE IS NO DOCUMENT 0

##############
## CLEANING ##
##############

#see available transformations from tm package
getTransformations()

#build content transformer "toSpace" which will replace chars with spaces
toSpace = content_transformer(function(x,pattern) {return (gsub(pattern, " ", x))})



#use toSpace to replace hyphens with spaces
SOTUs2 = tm_map(SOTUs, toSpace, "-")

#use toSpace to replace colons with spaces
SOTUs2 = tm_map(SOTUs2, toSpace, ":")

#inspect a particular document
writeLines(as.character(SOTUs3[[20]]))

#use toSpace to replace semicolons with spaces
SOTUs2 = tm_map(SOTUs2, toSpace, ";")

#use toSpace to replace percent-signs with spaces
SOTUs2 = tm_map(SOTUs2, toSpace, "%")

#use toSpace to replace dollar-signs with spaces
SOTUs2 = tm_map(SOTUs2, toSpace, "$")
# this is not working.
## hey so according to my other script that I'm borrowing, $ are special characters in R! I should maybe try "\\$"

#RYO: build content transformer to swap $ for "dollars"
toDollars = content_transformer(function(x,pattern) {return (gsub(pattern, "dollars", x))})

#use toDollars to change dollar signs to "dollars"
SOTUs3 = tm_map(SOTUs2, toDollars, "$")
#this shit isn't working either wtf

#lets try one more:
replaceDollars = function(x) gsub("?","dollars",x)

#then:
SOTUs3 = tm_map(SOTUs2, replaceDollars)

#this makes a totally fucked up SOTUs3 file so, use remove to remove it:
remove(SOTUs3)

#turns out there's already a function to remove punctuation built into tm:
SOTUs3 = tm_map(SOTUs, removePunctuation)
#yeah that worked. would still like to replace $ with "dollars" though.

#Transform to lower case (need to wrap in content_transformer)
SOTUs4 = tm_map(SOTUs3,content_transformer(tolower))

#inspect a particular document
writeLines(as.character(SOTUs3[[20]]))

#Strip digits (std transformation, so no need for content_transformer)
docs <- tm_map(docs, removeNumbers)
#not using this because numbers could be useful.

#remove stopwords using the standard list in tm
SOTUs5 = tm_map(SOTUs4, removeWords, stopwords("english"))

#Strip whitespace (cosmetic?)
SOTUs5 = tm_map(SOTUs5, stripWhitespace)

##############
## STEMMING ##
##############

#load library
library(SnowballC)

#Stem document
stemmedSOTUs = tm_map(SOTUs5,stemDocument)

#inspect
writeLines(as.character(stemmedSOTUs[[30]]))

#fix errors
stemmedSOTUs = tm_map(stemmedSOTUs, content_transformer(gsub), pattern = "[wordToReplace]", replacement = "[replacementWord]")

#################################
## Create document-term matrix ##
#################################

# generate DTM from simpleCorpus
dtm = DocumentTermMatrix(stemmedSOTUs)

#inspect the dtm
dtm

# display terms 1000 through 1005 in the first two rows of the DTM.
inspect(dtm[1:2,1000:10005])

############
## mining ##
############

# create columnMatrix "freq" from the dtm
freq <- colSums(as.matrix(dtm))

#length should be total number of terms, which you can check with dtm
length(freq)

#create sort order (descending)
ord = order(freq,decreasing=TRUE)

#inspect most frequently occurring terms
freq[head(ord)]

#inspect least frequently occurring terms
freq[tail(ord)]

#Here we have told R to include only those words that occur in  3 to 27 documents. We have also enforced  lower and upper limit to length of the words included (between 4 and 20 characters).
dtmr <-DocumentTermMatrix(docs, control=list(wordLengths=c(4, 20),
bounds = list(global = c(3,27))))
#not using this, also not sure how to break it into two different operations

# get a list of terms that occur at least 1500 times
findFreqTerms(dtm,lowfreq=1500)

## FIND ASSOCIATIONS
####################

#findAssocs(corpus, "wordToFind", correlation%)
findAssocs(dtm,"govern",0.8)

findAssocs(dtm,"afghanistan",0.7)
#you really have to play with the % to find useful info here.

#############
## DATAVIS ##
#############

#idk, i guess we need a "data frame" (a list of columns of equal length: "term" and "occurence")
wf=data.frame(term=names(freq),occurrences=freq)

#load ggplot2 library
library(ggplot2)

#invoke ggplot, only terms occurring 2000+ times, "aes" is for aesthetics, i guess?
p = ggplot(subset(wf, freq>2000), aes(term, occurrences))

#map bar height to the data value that is mapped to the y-axis(i.e occurrences)
p = p + geom_bar(stat="identity")

#x-axis labels should be at a 45 degree angle and should be horizontally justified
p = p + theme(axis.text.x=element_text(angle=45, hjust=1))

#print result
p

#'twould be good to learn how to get these in order