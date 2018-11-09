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
    $term = clean_input($_GET["searchTerm"]);
  } //if the form is filled out, clean the "searchTerm" and store as $term

  function clean_input($data) { //function to clean input
  $data = trim($data); //trim white space from end
  $data = stripslashes($data); //remove backslashes (since they are escape characters)
  $data = htmlspecialchars($data); //convert special characters to html entities
  $data = strtolower($data); //convert input to lowercase
  return $data;
  }

  $list = "obama, washington, froosevelt, troosevelt";
  $cleanTerm = '/' . $term . '/';
  $matches = preg_match_all($cleanTerm, $list, $matches_out);

  if ($term == "obama"){
    $myFile = fopen("../speeches-ucsb-pres-project/2012-01-24-obama.md", "r");
    $path = "../speeches-ucsb-pres-project/2012-01-24-obama.md";
    #echo fread($myFile, filesize($path));

  } else if ($term == "washington") {
    $myFile = fopen("../speeches-ucsb-pres-project/1790-01-08-washington.md","r");
    $path = "../speeches-ucsb-pres-project/1790-01-08-washington.md";
  } else {
    $myFile = fopen("../msg/search-error-demo.txt","r");
    $path = "../msg/search-error-demo.txt";

  }

  ?>

    <div class="w3-top">
      <?php include 'topnav.php';?>
    </div> <!-- end w3-top -->

    <div class="w3-container w3-row-padding"><br>
      <div class="w3-half">
        <div class="w3-card w3-white w3-bar-block">
          <div class="w3-bar w3-padding w3-purple">
            <h1>search results</h1>
          </div> <!-- end title bar for card -->
          <div class="w3-bar w3-white w3-padding">
            <p>You searched for <b>
                <?php echo $term ?></b></p>
            <p>Matches: <b>
                <?php echo $matches ?></b></p>
            <p>MatchesOut:
              <?php
  print_r($matches_out);
?>
            </p>

          </div>
        </div> <!-- end card -->
      </div> <!-- end cell 1 -->

      <div class="w3-cell">
        <div class="w3-card w3-white w3-bar-block">
          <div class="w3-bar w3-padding w3-purple">
            <h1>SOTU text</h1>
          </div>
          <div class="w3-bar w3-white w3-padding"  style="overflow:scroll">
            <p>
              <?php echo fread($myFile, filesize($path)) ?>
            </p>
          </div>
        </div> <!-- end cell 2 -->
      </div> <!-- end main section of card -->
    </div>
  </body>
</html>
