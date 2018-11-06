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
?>
You searched for <?php echo $term ?>

<?php
#$myFile = fopen("sentiments.txt", "w"); #opens (and creates if necessary) sentiments.txt as $myFile
#$myScript = fopen("myscript.R", "r"); # opens myscript.R as $myScript
#$output = shell_exec(`Rscript myscript.R`);
#passthru('Rscript ./myscript.R > ./sentiments.txt', $returnVal);
#shell_exec("'butts' >> sentiments.txt");

$results =`Rscript myscript.R`;
fwrite($myFile, fread($results, length($results)));
#exec()
echo $results;
echo $myFile;
#echo $returnVal;
#fwrite($myFile, $output);
#fwrite($myFile, fread($myScript,filesize("myscript.R"))); #writes ($to myFile, readscontent of $myScript for as many bytes as myscript.R is long)
fclose($myScript); #close $myScript
fclose($myFile); #close $myFile
# Rscript myscript.R > sentiments.txt
# echo "<pre>".$myFile . "</pre>";
#ok well this version creates sentiments.txt and writes the myscript.R into it. just need to get it to write the output, not the script itself, and we're good to go
?>
