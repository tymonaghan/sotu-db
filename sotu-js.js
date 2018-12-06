function showDropMenu() {
  var x = document.getElementById("mobilemenu");
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }
} //end myFunction

function updateFilterSearch() {
  var input, filter, ul, li, a, i;
  input = document.getElementById("filterSearchBox");
  filter = input.value.toUpperCase();
  ul = document.getElementById("myUL");
  li = ul.getElementsByTagName("li");
  for (i = 0; i < li.length; i++) {
    a = li[i].getElementsByTagName("a")[0];
    if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
      li[i].style.display = "";
    } else {
      li[i].style.display = "none";
    }
  }
}

function loadSOTUforViewer(year) {
  if (year == 1790) {
    document.getElementById("fileViewerFrame").src = "speeches-ucsb-pres-project/1790-01-08-washington.md"
  } else if (year == 1797) {
    document.getElementById("fileViewerFrame").src = "speeches-ucsb-pres-project/1797-11-22-adams.md"
  } else if (year == 2012) {
    document.getElementById("fileViewerFrame").src = "speeches-ucsb-pres-project/2012-01-24-obama.md"
  }
} //end loadSOTUforViewer

function loadExtra(extraName){
//document.getElementsByClassName("extras").style.display="none";
//document.getElementById(extraName).style.display="block";
if (extraName=="is-thy-union-here"){
  document.getElementById("extrasViewerFrame").src="contributors/taylorcate/_Is Thy Union Here__.pdf";
} else if (extraName=="redacted-unions"){
  document.getElementById("extrasViewerFrame").src="contributors/RJP43/contribution_01/README.md";
} else if (extraName == "trivia-of-the-union"){
  document.getElementById("extrasViewerFrame").src="output/msg/trivia-otu-wait.md";
}
}

function openTab(tabName) { //really not sure why i can't get this to work with the w3-hide/w3-show arrangement like showDropMenu, but style=display works for now.
  var i;
  var tablinks = document.getElementsByClassName("tablink");
  var x = document.getElementsByClassName("tab");
  document.getElementById("textSearch").value = "";
  document.getElementById("byYear").value = "";
  //document.getElementById("extras").value="";
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
    tablinks[i].className = tablinks[i].className.replace(" w3-light-blue", "");
  }
  document.getElementById(tabName).style.display = "block";
  document.getElementById(tabName.concat("", "button")).className += " w3-light-blue";
} //end openTab function

function includeHTML() {
  var z, i, elmnt, file, xhttp;
  /*loop through a collection of all HTML elements:*/
  z = document.getElementsByTagName("*");
  for (i = 0; i < z.length; i++) {
    elmnt = z[i];
    /*search for elements with a certain atrribute:*/
    file = elmnt.getAttribute("w3-include-html");
    if (file) {
      /*make an HTTP request using the attribute value as the file name:*/
      xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4) {
          if (this.status == 200) {
            elmnt.innerHTML = this.responseText;
          }
          if (this.status == 404) {
            elmnt.innerHTML = "Page not found.";
          }
          /*remove the attribute, and call this function once more:*/
          elmnt.removeAttribute("w3-include-html");
          includeHTML();
        }
      }
      xhttp.open("GET", file, true);
      xhttp.send();
      /*exit the function:*/
      return;
    }
  }
}

function closeModal() {
  document.getElementById(" restrictionsModal").style.display = "none";
}

function toggleRestrictionsBanner(){
  document.getElementById(" restrictionsBanner").style.display = "none";
}
