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
C:\Program Files\R\R-3.5.1\bin\RScript.exe
```
<br>**Ubuntu:**
```
/usr/lib/R/bin/Rscript
```
---

##### super-simple-output-tester.php
**line:** 23
<br>**Windows:**
```
$output = `C:\"Program Files"\R\R-3.5.1\bin\RScript.exe ../r-scripts/simple-summary.R $year`;
```
<br>**Ubuntu:**
```
$output = `/usr/lib/R/bin/Rscript ../r-scripts/simple-summary.R $year`;
```
