<html>
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

if ($term == "obama"){
  $myFile = fopen("../speeches-ucsb-pres-project/2012-01-24-obama.md", "r");
  $path = "../speeches-ucsb-pres-project/2012-01-24-obama.md";
} else if ($term == "washington") {
  $myFile = fopen("../speeches-ucsb-pres-project/1790-01-08-washington.md","r");
  $path = "../speeches-ucsb-pres-project/1790-01-08-washington.md";
} else {
  $myFile = "your file wasn't found, try searching for washington or obama.";
  $path = strlen($myFile);
}
#exec("Rscript ../r-scripts/quick-SOTU-sum.R", $output);
#$myFile = fopen("sentiments.txt", "w"); #opens (and creates if necessary) sentiments.txt as $myFile

#$result = system("Rscript ../r-scripts/r-cli/myscript.R");
#$scriptOutput = `Rscript ../r-scripts/r-cli/myscript.R | echo`;
#non-append version (overwrite) on below line, uncomment to use
#file_put_contents("sentiments.txt",$result/*, FILE_APPEND*/);
#$resultz = system ("buttssss");
#foreach ($output as $line)
#{
#  echo "$line <br>";
#}
#file_put_contents("sentiments.txt",serialize($output), FILE_APPEND);
#fclose($myFile);
#echo $output;
#replace fopen, fwrite, and fclose with file_put_contents
# the parameters are (file to open/write, data to write, flags [FILE_APPEND] writes in append instead of overwrite mode

#$outputt = fopen("sentiments.txt","r");
echo fread($myFile, filesize($path));

?>
<br>
you searched for <?php echo $term ?>
<br>
  your output is <?php echo $output ?>
<br>
by line: <?php echo $outputbyline ?>
<br>
your "serialized" output is <?php echo serialize($output) ?>
<br>
outputt of sentiments.txt is <?php echo $outputt ?>
<br><br>
<?php

?>

</body>
</html>
