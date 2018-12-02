#### handle input arguments ####
arguments = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(arguments)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} 

cat(arguments[1])
