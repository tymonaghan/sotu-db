![Wilson-1950](https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Photograph_of_President_Truman_delivering_his_State_of_the_Union_address_to_a_joint_session_of_Congress._-_NARA_-_200188.jpg/593px-Photograph_of_President_Truman_delivering_his_State_of_the_Union_address_to_a_joint_session_of_Congress._-_NARA_-_200188.jpg)
## Objective:
Create a user-friendly interactive database of text documents from the State of the Union addresses through history. Allow users to search, compare documents, create visualizations, and perform computational tasks on the text.

## Development Blog
[Please visit the SOTU-db development blog here!](http://blog.sotu-db.com/) 

## Product Goals:

### Primary Goals - Minimum Viable Product

-create online repository of plain text files of each SOTU*

-create web interface with full-text search for all SOTUs*

-enable visualizations of textual patterns, e.g. occurences of a particular word or phrase over time across all SOTUs

-create clickable "cards" with search suggestions, provocative quotes, trivia, etc. to guide and encourage playful user engagement

### Secondary Goals

-create a TEI schema and encode one or more documents manually

-use Processing to create visualizations with options to sort, color-code, and filter results

-integrate analysis through R to enable users to perform textual analysis right in the web interface

-game features, such as "match the President to the reading level" or "guess whose SOTUs were longer"

### Stretch / future Goals

-integrate a way of visualizing the audience reaction to the speeches as given (when possible), such as showing which states have reps who gave standing ovations at which times, etc. At least have a way to visualize the political makeup of Congress at the time of the speech. 

-integrate with Twitter to enable users to see the Twitter response to different parts of the address for recent SOTUs

-integrate primary source documents and drafts to create digital critical editions of certain SOTUs

### Out of Scope:
-video or audio files of addresses

-public interaction like wikis, comments, etc

## Team:
-**Tyler Monaghan:** Project lead, Processing visualizations

-**Abdur Khan:** Project assistant, Python/R analysis

-**Tina Figueroa:** Project assistant, social media integration

## Schedule:
**Tuesday, May 1:** Final Exams -- Minimum Viable Product complete

## Survey of existing resources:

-[”State of the union messages” at the American Presidency Project](http://www.presidency.ucsb.edu/sou.php)

-[Historical state of the union addresses on archives.gov](https://www.archives.gov/legislative/features/sotu)

-[An analysis from R about Trump’s 2018 SOTU address](http://blog.revolutionanalytics.com/2018/01/trump-sotu.html)

-[A similar project to SOTU-db but not a very pleasing interface](http://stateoftheunion.onetwothree.net/index.shtml)

-[Buzzfeed analysis of Trump's 2018 SOTU, with R code on Github](https://buzzfeednews.github.io/2018-01-trump-state-of-the-union/)

-[Textual analysis of Obama’s Sixth Annual Address and visual supplements](http://www.digitalhumanities.org/dhq/vol/10/4/000280/000280.html)

## Note:
I use the term "SOTU" to describe any written or verbally delivered address included in the list at the [American Presidency Project.](http://www.presidency.ucsb.edu/sou.php)