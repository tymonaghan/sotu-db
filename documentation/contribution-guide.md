## SOTU-db Contribution Guide

*Here to contribute? Put your work in /contributors/YOURGITHUBNAME and submit a pull request!*

#### Contributing
##### Code
Please check the issues board for "help wanted" issues. Pull requests addressing "help wanted" issues are welcome. For other issues, contact me to discuss. Please be aware, as this is an academic project, pull requests for general code and feature improvements or issues other than "help wanted" usually won't be considered.

##### Prose
Currently seeking writers and scholars to contribute pieces discussing:
- the context surrounding the delivery of certain SOTUs, for example explaining that the nation had just declared war or the President's recent margin of victory
- the relationship between computer-driven textual analysis and sentiment
- the specific rhetorics and symbolism of the State of the Union process
- questions of authorship when dealing with multiple authors and the presidential "head of state" role
- the effectiveness of the sentiment analysis tools used in this software

please contact tmonaghan@luc.edu if you would like to contribute in this way.

##### Setup
1. [Install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) to your computer

2. clone the SOTU-db repo to your computer:
```
git clone https://github.com/YOURGITHUBNAME/sotu-db.git
```
Or download the files in the repo from Github via your browser.

##### Workflow:

1. Edit the files within the project file structure on your computer as usual. Save your changes and exit programs that generate temp files (e.g. MS Office) when you are done.

2. Add your changes to git (from within sotu-db folder):
```
git add .
```

5. Commit your changes with a brief summary of what you did (from within sotu-db folder):
```
git commit -m "i changed some files and now they are better"
```

6. Push your commit back out to GitHub (from within sotu-db folder
```
git push
```

7. This will create a pull request from your version to "master." This means you are "requesting" that I "pull" your changes into the master branch

8. I will deploy accepted pull requests to the live server

9. Comment on the issue with what you did, step by step, and how, with examples in block code when appropriate
