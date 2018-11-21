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
  - Only one SOTU per year is provided for Jimmy Carter (Carter provided both verbal and written SOTUs in 1978-80)
  - Speeches from Obama (2016) and Trump (2018) are included in this folder but are *not* sourced from project Gutenberg
- **speeches-ucsb-pres-project** is still being compiled.

### File Naming Scheme
- **speeches-cspan:** yyyy-Presidentlastname.txt
- **speeches-gutenberg:** yyyy-Presidentname-m-dd-p.txt
<br>  - In some cases, friendly names are used; "FDR," "BenHarrison," "WBush," "HWBush," etc
- **speeches-ucsb-pres-project:** yyyy-mm-dd-Presidentlastname.md
<br>  - Jimmy Carter's 1978 SOTUs have a v for verbal and w for written inserted as in: "1978-01-19-v-carter.md"


### Editorial Policy
#### General Editorial Policy
##### Signatures
As many annual addresses were delivered in writing rather than verbally, some documents contain signatures. These are often just the President's name, but can also contain dates or locations ("The White House").  Except un-edited texts (such as the C-Span corpus), signatures have been omitted from the texts used in this project.

##### Salutations
 Salutations ("Gentlemen of the House of Representatives") have been left intact.

##### Bullet Points and Headings
Some SOTUs make use of bullet points and headings. In general, these are preserved within the SOTU-db texts, in accordance with their presentation in the source material. The texts have not been thoroughly checked for consistency in the rendering of bullet points; these will generally be excluded from the texts as a part of processing.

#### Corpus-specific Editorial Policies
**speeches-cspan:**
- no editing
- this preserves a large number of strange characters and inconsistencies in the texts

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
