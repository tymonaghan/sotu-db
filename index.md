![Wilson-1950](https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Photograph_of_President_Truman_delivering_his_State_of_the_Union_address_to_a_joint_session_of_Congress._-_NARA_-_200188.jpg/593px-Photograph_of_President_Truman_delivering_his_State_of_the_Union_address_to_a_joint_session_of_Congress._-_NARA_-_200188.jpg)

## Objective:

Create a user-friendly interactive database of text documents from the State of the Union addresses through history and allows users to perform sentiment analysis on arbitrary search strings (words or phrases) within the database.

## Development Blog

[Please visit the SOTU-db development blog here!](http://blog.sotu-db.com/)

## Product Goals:

### Primary Goals - Minimum Viable Product / Must-Haves

- create online repository of plain text files of each SOTU\*

- web interface accessible from any browser by entering the URL, contains a search box for user to enter a search strings

- system finds that search string in database of SOTU texts and performs sentiment analysis on each occurrence

- system returns results of sentiment analysis to user

### Secondary Goals / Would-haves

- create web interface with full-text search for all SOTUs\*

- enable visualizations of textual patterns, e.g. occurrences of a particular word or phrase over time across all SOTUs

- create clickable "cards" with search suggestions, provocative quotes, trivia, etc. to guide and encourage playful user engagement

- use Processing to create visualizations with options to sort, color-code, and filter results

- integrate analysis through R to enable users to perform textual analysis right in the web interface

- game features, such as "match the President to the reading level" or "guess whose SOTUs were longer"

### Stretch / future Goals / Could-haves

- integrate a way of visualizing the audience reaction to the speeches as given (when possible), such as showing which states have reps who gave standing ovations at which times, etc. At least have a way to visualize the political makeup of Congress at the time of the speech.

- create a TEI schema and encode one or more documents manually

- integrate with Twitter to enable users to see the Twitter response to different parts of the address for recent SOTUs

- integrate primary source documents and drafts to create digital critical editions of certain SOTUs

### Out of Scope:

- video or audio files of addresses

- public interaction like wikis, comments, etc

## Team:

- **Tyler Monaghan:** Project lead, Processing visualizations

- **Abdur Khan:** Project assistant, Python/R analysis

- **Tina Figueroa:** Project assistant, social media integration

## Schedule / Milestone Goals:

**October 10, 2018:** Front-end interface options complete (HTML, React Native?)

**October 20, 2018:** Have basic sentiment analysis script in RStudio saved and tested

**November 1, 2018:** Front-end is live and publicly accessible

**November 10, 2018:** R and Rstudio Server are installed on publicly-accessible Server

**November 25, 2018:** Must-have features complete (minimum viable product). Public user can access the site, enter a search term, and see results

**December 4, 2018:** Minimum Viable Product deadline - live demo at CTSDH

## Survey of existing resources:

- [”State of the union messages” at the American Presidency Project](http://www.presidency.ucsb.edu/sou.php)

- [Historical state of the union addresses on archives.gov](https://www.archives.gov/legislative/features/sotu)

- [An analysis from R about Trump’s 2018 SOTU address](http://blog.revolutionanalytics.com/2018/01/trump-sotu.html)

- [A similar project to SOTU-db but not a very pleasing interface](http://stateoftheunion.onetwothree.net/index.shtml)

- [Buzzfeed analysis of Trump's 2018 SOTU, with R code on Github](https://buzzfeednews.github.io/2018-01-trump-state-of-the-union/)

- [Textual analysis of Obama’s Sixth Annual Address and visual supplements](http://www.digitalhumanities.org/dhq/vol/10/4/000280/000280.html)

### \*Note:

I use the term "SOTU" to describe any written or verbally delivered address included in the list at the [American Presidency Project.](http://www.presidency.ucsb.edu/sou.php)
