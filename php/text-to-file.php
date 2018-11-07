<?php
exec("Rscript ../r-scripts/r-cli/myscript.R > sentiments.txt");
#$scriptOutput = `Rscript ../r-scripts/r-cli/myscript.R | echo`;
#non-append version (overwrite) on below line, uncomment to use
#file_put_contents("../sentiments.md","Text is getting appended then a line break <br>"/*, FILE_APPEND*/);
#echo $output;
#replace fopen, fwrite, and fclose with file_put_contents
# the parameters are (file to open/write, data to write, flags [FILE_APPEND] writes in append instead of overwrite mode
$outputt = fopen("../r-scripts/r-cli/sentiments.txt","r");
echo fread($outputt,filesize("../r-scripts/r-cli/sentiments.txt"));
?>
