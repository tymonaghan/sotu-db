## SOTU-db Contribution Guide

#### Setup
1. [Install git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) to your computer

2. Fork SOTU-db to your computer by going to the [SOTU-db repo](https://github.com/tymonaghan/sotu-db) and clicking "fork" at the top of the screen. This will create a "SOTU-db" repo in your GitHub account.

3. clone your forked SOTU-db repo to your computer:
```
git clone https://github.com/YOURGITHUBNAME/sotu-db.git
```
Or download them from Github.

#### Workflow:

4. Edit the files as usual on your computer. Save your changes and exit programs that generate temp files (e.g. MS Office) when you are done.

4. Add your changes to git:
```
git add .
```

5. Commit your changes with a brief summary of what you did
```
git commit -m "i changed some files and now they are better"
```

6. Push your commit back out to GitHub
```
git push
```
7. Go back to the SOTU-db repo on GitHub, and submit a pull request from your version to "master." This means you are "requesting" that I "pull" your changes into the master branch

8. I will deploy accepted pull requests to the live server

9. Let me know whether you will close the GitHub issue, if not I will do so
