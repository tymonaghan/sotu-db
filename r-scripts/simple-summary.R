#### handle input arguments ####
args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} 
SOTUtoDisplay = args[1]

#SOTUtoDisplay

#### load packages, setwd ####
setwd("C:/Users/tnmon/git/sotu-db/speeches-sample")
library(tm)

#### create corpus ####
SOTUs = Corpus(DirSource("./"))

#### inspect document ####

SOTUs[SOTUtoDisplay]

writeLines(as.character(SOTUs[[as.integer(SOTUtoDisplay)]]))
