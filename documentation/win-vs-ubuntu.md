## Windows versus Ubuntu
This document catalogs differences between the SOTU-db file tree in Windows (production) and that in Ubuntu (deployment).

---
#### SOTU-db home (git directory) ####
<br>**Windows:**
```
C:\users\tnmon\git\sotu-db\
```
<br>**Ubuntu:**
```
$output = `/usr/lib/R/bin/Rscript ../r-scripts/simple-summary.R $year`;
```
---

#### SOTU-db home (server directory) ####
<br>**Windows:**
```
C:\apache24\htdocs\
```
<br>**Ubuntu:**
```
\var\www\sotu-db.cs.luc.edu\html\
```
---
#### Rscript executable location ####
<br>**Windows:**
```
C:\Program Files\R\R-3.5.2\bin\RScript.exe
```
<br>**Ubuntu:**
```
/usr/lib/R/bin/Rscript
```
---

##### simple-summary-with-sentimentPlot.R ####
*this has been corrected and made platform-agnostic, previous details below:*
**line:** 28-31
<br>**Windows:**
```
#load("C:/Users/tnmon/git/sotu-db/r-env/tidytokens-sample.RData")
#setwd("C:/Users/tnmon/git/sotu-db/speeches-sample")
```
<br>**Ubuntu:**
```
#load("/var/www/sotu-db.cs.luc.edu/html/r-env/tidytokens-sample.RData")
#setwd("/var/www/sotu-db.cs.luc.edu/html/speeches-sample")
```
