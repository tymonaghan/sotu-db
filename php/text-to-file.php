<?php
exec("echo happy >> sentiments.txt");
#$result = system("Rscript ../r-scripts/r-cli/myscript.R");
#$scriptOutput = `Rscript ../r-scripts/r-cli/myscript.R | echo`;
#non-append version (overwrite) on below line, uncomment to use
#file_put_contents("sentiments.txt",$result/*, FILE_APPEND*/);
#$resultz = system ("buttssss");

#file_put_contents("sentiments.txt",$resultz/*, FILE_APPEND*/);
#echo $output;
#replace fopen, fwrite, and fclose with file_put_contents
# the parameters are (file to open/write, data to write, flags [FILE_APPEND] writes in append instead of overwrite mode
$output = fopen("sentiments.txt","r");
echo fread($output, filesize("sentiments.txt"));
?>
