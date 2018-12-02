
<?php
echo '
<div class="w3-card w3-block-bar" style="min-height:400px">
  <header class="w3-container w3-light-gray">
    <div class="w3-text">
      <h3>Search and perform sentiment analysis on a corpus of State of the Union address texts</h3>
    </div>
  </header>
  <div class="w3-bar w3-light-gray">
    <!--tab bar -->
    <button class="w3-bar-item w3-button w3-border-right w3-border-left w3-border-top tablink w3-light-blue" onclick="openTab("search")" id="searchbutton">Search by term</button>
    <button class="w3-bar-item w3-button w3-border-right w3-border-top tablink" onclick="openTab("filter")" id="filterbutton">Filter list view</button>
    <button class="w3-bar-item w3-button w3-border-top w3-border-right tablink" onclick="openTab("fileviewer")" id="fileviewerbutton">File viewer</button>
  </div> <!-- end w3-bar tab-bar -->
  <div id="search" class="tab w3-container w3-padding">
    <form method="GET" action="php\coreNLP-1.php">
      <label>Enter your search term:</label>
      <input class="w3-input w3-border w3-round" type="text" name="searchTerm" placeholder="try Obama or Washington..." id="searchBox" required></input>

      <p><i>please note searches are not encrypted and should not be considered private</i></p>

      <input type="submit" value="Submit"></input>
      <div class="w3-right">
        <h4>chunk size</h4>
        <form>
          <input class="w3-radio" type="radio" name="chunkSize" id="chunkSize25" value="25" />
          <label for="chunkSize25">25</label>
          <input class="w3-radio" type="radio" name="chunkSize" id="chunkSize50" value="50" />
          <label for="chunkSize50">50</label>
          <input class="w3-radio" type="radio" name="chunkSize" id="chunkSize75" value="75" checked />
          <label for="chunkSize75">75</label>
          <input class="w3-radio" type="radio" name="chunkSize" id="chunkSize100" value="100" />
          <label for="chunkSize100">100</label>
        </form>
        <!--<input class="w3-check" type="checkbox" name="chunkSize" id="chunkSize" value="25">
        <label>25</label></input>
        <input class="w3-check" type="checkbox" id="chunkSize" value="50" name="chunkSize">
        <label>50</label></input>
        <input class="w3-check" type="checkbox" checked="checked" id="chunkSize" value="75" name="chunkSize">
        <label>75</label></input>
        <input class="w3-check" type="checkbox" id="chunkSize" value="100" name="chunkSize">
        <label>100</label></input>-->
      </div>
  </div> <!-- end search -->
  <div id="filter" class="tab w3-container" style="display:none">
    <div class="w3-container">
      <h2>Filter List</h2>
      <p>Search for a name in the input field.</p>
      <input class="w3-input w3-border w3-padding" type="text" placeholder="Search for names.." id="filterSearchBox" onkeyup="updateFilterSearch()">
      <ul class="w3-ul w3-margin-top" id="myUL">
        <li><a href="php\slightly-less-simple-output-tester.php?searchTerm=1981">Reagan 1981</a></li>
        <li><a href="php\slightly-less-simple-output-tester.php?searchTerm=1985">Reagan 1985</a></li>
        <li><a href="php\slightly-less-simple-output-tester.php?searchTerm=1989">Bush 1989</a></li>
        <li><a href="php\slightly-less-simple-output-tester.php?searchTerm=1993">Clinton 1993</a></li>
        <li><a href="php\slightly-less-simple-output-tester.php?searchTerm=1997">Clinton 1997</a></li>
        <li><a href="php\slightly-less-simple-output-tester.php?searchTerm=2001">Bush 2001</a></li>
        <li><a href="php\slightly-less-simple-output-tester.php?searchTerm=2005">Bush 2005</a></li>
        <li><a href="php\slightly-less-simple-output-tester.php?searchTerm=2009">Obama 2009</a></li>
        <li><a href="php\slightly-less-simple-output-tester.php?searchTerm=2013">Obama 2013</a></li>
        <li><a href="php\slightly-less-simple-output-tester.php?searchTerm=2017">Trump 2017</a></li>
      </ul>
    </div>
  </div> <!-- end filter -->

  <div id="fileviewer" class="tab w3-container" style="display:none">
    <div class="w3-cell-row">
      <div class="w3-cell">
        <p>Select a file to view:</p>
      </div>
      <div class="w3=cell"> <button onclick="loadSOTUforViewer("1790")">Washington 1790</button></div>
      <div class="w3-cell"><button onclick="loadSOTUforViewer("1797")">Adams 1797</button></div>
      <div class="w3-cell"><button onclick="loadSOTUforViewer("2012")">Obama 2012</button></div>
    </div>
    <iframe class="w3-mobile w3-block" style="min-height:500px" id="fileViewerFrame">
      <p>your browser does not support this view.</p>
    </iframe>
  </div> <!-- end fileviewer -->
</div> <!-- end w3-card -->
';
?>
