<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="https://github.com/tymonaghan/sotu-db/raw/master/images/favicon.png">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <title>SOTU-db</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <style>
    html{

    }
      body {
        background: url("../images/Obama_waves_State_of_the_Union_2011-lightened.jpg") no-repeat center;
        background-size: cover;
      }
    </style>
  </head>

  <body>
    <?php
    //this block checks for windows or linux and sets $RScript path accordingly
      $RScript = '/usr/lib/R/bin/Rscript';
      if (strcasecmp(substr(PHP_OS_FAMILY, 0, 3), 'WIN') == 0) {
          $RScript='C:\"Program Files"\R\R-3.5.1\bin\RScript.exe';
      }

    if ($_SERVER["REQUEST_METHOD"] == "GET") {
        $rawQuery = $_GET["searchTerm"];
        $rawChunkSize = $_GET["chunkSize"];
        $query = escapeshellcmd($rawQuery);
        $chunkSize = escapeshellcmd($rawChunkSize);
    } //if the form is filled out, clean the "searchTerm" and store as query

    function clean_input($data)
    { //function to clean input
    $data = trim($data); //trim white space from end
    $data = stripslashes($data); //remove backslashes (since they are escape characters)
    $data = htmlspecialchars($data); //convert special characters to html entities
    $data = strtolower($data); //convert input to lowercase
    return $data;
    }

    $output = `$RScript ../r-scripts/new-regex-finder.R $query`;


    $matchCount = file_get_contents("../output/matchCount.txt");
    $matchedSentences = file("../output/matchSentences.txt");
    $matchedSentencesWithSentiment = file("../output/sentimentDirections.txt");
    ?>

    <div class="w3-top" id="topnav">
      <?php include 'topnav.php';?>
    </div> <!-- end w3-top -->
    <div class="w3-content w3-container" id="mainContent">
      <br><br><br><br><!-- the calculateYoffsets thing isn't working here (probably bc using w3-content) so just <br>x3 for now -->
      <div class="w3-card w3-white">
        <header class="w3-container w3-purple">
          <div class="w3-text">
            <h3>Results</h3>
          </div>
        </header>
        <div class = "w3-container w3-light-gray">
        <h3>your query:
          <b><?php echo $query ?></b>
        </h3>
        <h3><b>your corpus: </b>1978 - 2017</h3>
      </div>
      <div class = "w3-container">
        <h3><b>number of times your search query appears: </b><?php echo $matchCount; ?> </h3>

<?php
        if ($matchCount > 1) {
            echo "<h3><b>sentiment trajectory:</b></h3>";
            echo "<img src='../output/sentimentMatchChart.png' alt='chart of each occurence of your query by year'/ style='max-width:100%'>";
        }

        ?>

        <h3><b>sentences:</b></h3>
        <?php
        foreach ($matchedSentencesWithSentiment as $line) {
            echo "<div class='w3-cell-row w3-border w3-hover-pale-blue'>";
            echo "<div class='w3-container w3-cell w3-cell-middle'>";
            echo $line;
            echo "</div></div>";
        }
        #echo $matchedSentences;
        ?>
      </div>
      </div> <!-- end w3-card -->
    </div> <!-- end w3-content div -->
  </body>
</html>
