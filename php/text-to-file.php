<?php
file_put_contents("../sentiments.md","Text is getting appended then a line break <br><br>", FILE_APPEND);
#non-append version (overwrite) on below line, uncomment to use
#file_put_contents("../sentiments.md","Text is getting appended then a line break <br>"/*, FILE_APPEND*/);

#replace fopen, fwrite, and fclose with file_put_contents
# the parameters are (file to open/write, data to write, flags [FILE_APPEND] writes in append instead of overwrite mode
$output = fopen("../sentiments.md","r");
echo fread($output,filesize("../sentiments.md"));
?>
