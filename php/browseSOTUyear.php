<!DOCTYPE html>
<html lang="en">
  <head>
    <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-105747352-3"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-105747352-3');
</script>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="https://github.com/tymonaghan/sotu-db/raw/master/images/favicon.png">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>SOTU-db</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="../../sotu-js.js"></script>

    <style>
      body {
        background: url("../images/Obama_waves_State_of_the_Union_2011-lightened.jpg") no-repeat center;
        background-attachment: fixed;
        background-size:cover;
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

//gather and command-escape the user selection
    if ($_SERVER["REQUEST_METHOD"] == "GET") {
        $rawYear = $_GET["searchYear"];
        $rawChunkSize = $_GET["chunkSize"];
        $year = escapeshellcmd($rawYear);
        $chunkSize = escapeshellcmd($rawChunkSize);
    } //if the form is filled out, clean the "searchTerm" and store as year

$output = `$RScript ../r-scripts/simple-summary-with-sentimentPlot.R $year $chunkSize`;

?>

<div w3-include-html="../html/topnav.html"></div>

    <div class="w3-content w3-container" id="mainContent">
      <div class="w3-card w3-white" style="position:relative;top:150px">
        <header class="w3-container w3-purple">
          <div class="w3-text">
            <h3>Results</h3>
          </div>
        </header>
        <div class = "w3-container w3-light-gray">
        <h2>SOTU year:<b>
            <?php echo $year ?></b></h2>
        <h2>chunk size: <b>
            <?php echo $chunkSize ?></b></h2>
        <img class="w3-image" src="../output/plot.png" alt="a graphical plot of the sentiment by chunkSize for your selected year">
      </div>
<div class="w3-container">
        <p><b>SOTU text used for analysis:</b>
          <?php print_r($output); ?>
        </p>
      </div>
      </div> <!-- end w3-card -->
    </div> <!-- end w3-content div -->
<script>
includeHTML();
</script>
  </body>
</html>
