<?php
echo '

<div class="w3-purple w3-bar">
  <a href="/" class="w3-bar-item w3-xxlarge w3-button"><b>SOTU-db</b></a>
  <button class="w3-bar-item w3-light-gray w3-border w3-border-white w3-round-large w3-hover-pale-yellow w3-margin" onclick="document.getElementById(\'helpModal\').style.display=\'block\'">Help</button>
  <a href="../html/credits.html" class="w3-bar-item w3-large w3-right w3-button w3-margin">Credits</a>
  <a href="../html/documentation.html" class="w3-bar-item w3-large w3-right w3-button w3-margin">Documentation</a>
  <a href="https://github.com/tymonaghan/sotu-db" class="w3-bar-item w3-large w3-right w3-button w3-margin">GitHub Repo  <i class="fa fa-external-link"></i></a>
  <a href="javascript:void(0)" class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium" onclick="showDropMenu()">&#9776;</a>
  </div>
<div id="mobilemenu" class="w3-bar-block w3-purple w3-hide w3-hide-large w3-hide-medium">
  <a href="https://github.com/tymonaghan/sotu-db" class="w3-bar-item w3-button w3-right">GitHub Repo <i class="fa fa-external-link"></i></a>
  <a href="../html/documentation.html" class="w3-bar-item w3-button w3-right">Documentation</a>
  <a href="../html/credits.html" class="w3-bar-item w3-button w3-right">Credits</a>
  </div>
  <div w3-include-html="../html/helpModal.html"></div>
<script>
  includeHTML();
</script>
  ';