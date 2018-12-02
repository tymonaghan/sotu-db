# Requirements

## Overview
SOTU-db is an online tool for searching and performing sentiment analysis on annual addresses delivered by the President of the United States (POTUS) to Congress each year, commonly known as "State of the Union" addresses (SOTUs). Users visit sotu-db.com, type in a search term, and SOTU-db returns each instance of that term occurring in the texts of SOTUs and the sentiment of each section of text in which the search term is found.

Below, find the primary requirements for SOTU-db, as well as secondary and tertiary "goals" that may become integrated into the project with time.

#### Primary Requirements - must-haves, minimum viable product
**These requirements must be met by Dec. 4 2018**
1. The SOTU-db GitHub repo contains plain-text files of every modern (post-1945) SOTU (the Corpus)
2. A public-facing landing page is accessible at www.sotu-db.com
<br>  2a. the landing page displays the project name
<br>  2b. the landing page contains a search box and a "submit" button
<br>  2c. the landing page contains links to project documentation
3. User can enter a text string (the Query) into the search box and click the "submit" button
4. SOTU-db locates each instance of the Query in the Corpus.
5. SOTU-db performs a sentiment analysis task on each segment of text in which the Query appears
6. SOTU-db returns a summary of each occurrence along with its associated sentiment to the user

#### Secondary Goals - would-haves, possible launch features
1. Web-accessible full-text search for all SOTUs
2. enable visualizations of textual patterns, e.g. occurrences of a particular word or phrase over time across all SOTUs
3. create clickable “cards” with search suggestions, provocative quotes, trivia, etc. to guide and encourage playful user engagement
4. use Processing to create visualizations with options to sort, color-code, and filter results
5. Game features, such as “match the President to the reading level” or “guess whose SOTUs were longer”
6. A Twitter feed of various presidential libraries and foundations is embedded into SOTU-db

#### Tertiary Goals - could-haves, possible long-term-support feature additions
1. integrate a way of visualizing the audience reaction to the speeches as given (when possible), such as showing which states have reps who gave standing ovations at which times, etc. At least have a way to visualize the political makeup of Congress at the time of the speech.
2. create a TEI schema and encode one or more documents manually
3. integrate with Twitter to enable users to see the Twitter response to different parts of the address for recent SOTUs
4. integrate primary source documents and drafts to create digital critical editions of certain SOTUs
