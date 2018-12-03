#### load coreNLP package and init ####
library(coreNLP)
library(glue)
library(stringr)
library(tidyverse)
library(tm)
library(dplyr)
libarr
initCoreNLP()

#### list files in directory to be used ####
files = list.files("../speeches-sample/small/")

getAnnotation = function(file){
  
  
}

for (i in files){
  
  fileName = glue("../speeches-sample/small/",i)
  annotateFile(fileName)
  
}

file = files[1]
filePath = "../speeches-sample/small/"
fileName = paste0(filePath,file)
paste0("annotated-",file) = annotateFile(fileName)


annotation1989 = annotateFile(fileName)
tokens1989 = getToken(annotation1989)
clearText1989 = readLines("../speeches-sample/1989-02-09-bush.md")
clearText1989 = gsub("\\$", "dollars ", clearText1989)


load("../r-env/tidytokens-sample.RData")
