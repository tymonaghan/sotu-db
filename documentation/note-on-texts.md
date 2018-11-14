# Note on the texts

## The "State of the Union"
[UCSB's American Presidency Project](https://www.presidency.ucsb.edu/documents/presidential-documents-archive-guidebook/annual-messages-congress-the-state-the-union) has an excellent explanation of "State of the Union" messages, including:
- why some SOTUs are not technically "state of the union" messages,
- which SOTUs were delivered as written messages and which were delivered verbally,
- why the "state of the union" has occurred at different times of year through history.

For the purposes of SOTU-db, all documents listed on the American Presidency Project's website linked above are considered "SOTUs."

## Corpora
SOTU-db contains three separate corpora of "State of the Unions."
- speeches-cspan
- speeches-gutenberg
- speeches-ucsb-pres-project

### Sources
 - **speeches-cspan** is sourced from the NLTK data packages. Here is the [direct link to the zip file on GitHub](https://github.com/nltk/nltk_data/blob/gh-pages/packages/corpora/state_union.zip). It includes the following note in a README:
> C-Span State of the Union Address Corpus
>
> Annual US presidential addresses 1945-2006
>
> http://www.c-span.org/executive/stateoftheunion.asp
>
> (Thanks to Kathleen Ahrens for compiling this corpus from
the C-Span sources.)

- **speeches-gutenberg** is sourced from [State of the Union Addresses (1790-2006) by United States. Presidents](http://www.gutenberg.org/ebooks/5050) by copying text from the "Plain Text (UTF-8)" document into individual plaintext files.

- **speeches-ucsb-pres-project** is sources from UCSB's American Presidency Project. Text was copied from each individual address page into individual markdown documents.

### Coverage
- **speeches-cspan** includes 65 SOTUs from 1945 - 2006.
  - Carter's written reports are excluded
- **speeches-gutenberg** includes 213 SOTUs from 1790 - 2006.
  - Grover Cleveland's second term is omitted
  - Speeches from Obama (2016) and Trump (2018) are included in this folder but are *not* sourced from project Gutenberg
- **speeches-ucsb-pres-project** is still being compiled.

### Editorial Policy
**speeches-cspan:**
- no editing

**speeches-gutenberg:**
- file headers omitted (president name, date)
- salutations included
- signatures omitted

**speeches-ucsb-pres-project:**
- file headers omitted (president name, date)
- salutations included
- signatures omitted (captured in index)
- some files contain "the president." and "audience members." to show who is speaking. Undecided how to address these.

## Metadata
The SOTU-db master index captures the following metadata for each SOTU:
- date delivered (year, month, date)
- the president's first and last name
- word count
- delivery method (verbal, written), and notes on delivery if needed
- the president's political party at the time the SOTU was delivered
- the president's elected term in office (first, second, or unelected)

In the future, SOTU-db could include:
- the president's approval rating at the time the SOTU was delivered
- the president's months in office at the time the SOTU was delivered

As many annual addresses were delivered in writing rather than verbally, some documents contain signatures. These have been omitted from the texts used in this project. Salutations ("Gentlemen of the House of Representatives") have been left intact.
