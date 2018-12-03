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

SOTUtoDisplay = args[1]
chunkSize = args[2]

#SOTUtoDisplay

#### load packages, workspace, setwd ####
setwd("C:/Users/tnmon/git/sotu-db/speeches-sample")
#setwd(/var/www/sotu-db.cs.luc.edu/html)
library(tm)
load("C:/Users/tnmon/git/sotu-db/r-env/tidytokens-sample.RData")


#### create corpus ####
#commenting out - should be able to load as workspace
#SOTUs = Corpus(DirSource("./"))


#### inspect document ####
SOTUs[SOTUtoDisplay]
writeLines(as.character(SOTUs[[as.integer(SOTUtoDisplay)]]))

###### plot data and write file #####

