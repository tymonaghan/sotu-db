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
?>

You searched for <?php echo $term ?>

</body>
</html>
