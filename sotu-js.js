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
    document.getElementById("fileViewerFrame").src = "sample-texts/1790-01-08-washington.md"
  } else if (year == 1797) {
    document.getElementById("fileViewerFrame").src = "sample-texts/1797-11-22-adams.md"
  } else if (year == 2012) {
    document.getElementById("fileViewerFrame").src = "sample-texts/2012-01-24-obama.md"
  }
} //end loadSOTUforViewer

function openTab(tabName) { //really not sure why i can't get this to work with the w3-hide/w3-show arrangement like above, but style=display works for now.
  var i;
  var tablinks = document.getElementsByClassName("tablink");
  var x = document.getElementsByClassName("tab");
  document.getElementById("searchBox").value = "";
  document.getElementById("filterSearchBox").value = "";
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
    tablinks[i].className = tablinks[i].className.replace(" w3-light-blue", "");
  }
  document.getElementById(tabName).style.display = "block";
  document.getElementById(tabName.concat("", "button")).className += " w3-light-blue";
} //end openTab function
