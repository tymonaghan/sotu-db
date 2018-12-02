<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="https://github.com/tymonaghan/sotu-db/raw/master/images/favicon.png">
    <link rel="stylesheet" href="/style/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>SOTU-db</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <style>
      body {
        background: url("../images/Obama_waves_State_of_the_Union_2011-lightened.jpg") no-repeat center;
        background-size: cover;
      }
    </style>
  </head>
  <body>
    <?php
    if ($_SERVER["REQUEST_METHOD"] == "GET") {
      $rawYear = $_GET["searchTerm"];
      $rawChunkSize = $_GET["chunkSize"];
      $year = escapeshellcmd($rawYear);
      $chunkSize = escapeshellcmd($rawChunkSize);
    } //if the form is filled out, clean the "searchTerm" and store as year

$output = `C:\"Program Files"\R\R-3.5.1\bin\RScript.exe ../r-scripts/simple-summary-with-sentimentPlot.R $year $chunkSize`;
#$output = `/usr/lib/R/bin/Rscript ../r-scripts/simple-summary-with-sentimentPlot.R {$year} {$chunkSize}`;
?>

  <div class="w3-top">
    <?php include 'topnav.php';?>
  </div> <!-- end w3-top -->
<div class="w3-content w3-container">
  <div class = "w3-card w3-white">
    <img src="../output/plot.png">
</div>
  <div class = "w3-card w3-white">
  <p>you searched for <?php echo $year ?> </p>
  <p>using chunkSize of <?php echo $chunkSize ?> </p>
  <br>
  <p><b>results:</b> <?php print_r($output); ?> </p>
</div> <!-- end w3-card -->
</div> <!-- end w3-content div -->

  </body>
</html>
