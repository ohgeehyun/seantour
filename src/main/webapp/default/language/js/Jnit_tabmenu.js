// Tab Content
function initTabMenu(tabContainerID) {
	var tabContainer = document.getElementById(tabContainerID);
	var tabAnchor = tabContainer.getElementsByTagName("a");
	var i = 0;

	for(i=0; i<tabAnchor.length; i++) {
		if (tabAnchor.item(i).className == "tab")
			var thismenu = tabAnchor.item(i);
		else
			continue;

		thismenu.container = tabContainer;
		thismenu.targetEl = document.getElementById(tabAnchor.item(i).href.split("#")[1]);
		thismenu.targetEl.style.display = "none";
		thismenu.imgEl = thismenu.getElementsByTagName("img").item(0);
		if (thismenu.imgEl) {
			thismenu.onfocus = function () {
				//this.onfocus();
			}
		}
		thismenu.onfocus = tabMenuOver;
		thismenu.onclick = tabMenuOver;

		if (!thismenu.container.first)
			thismenu.container.first = thismenu;
	}
	tabContainer.first.onfocus();
}

function tabMenuOver() {
	var currentmenu = this.container.current;
	if (currentmenu != this) {
		if (currentmenu) {
			currentmenu.targetEl.style.display = "none";
			if (currentmenu.imgEl) {
				currentmenu.imgEl.src = currentmenu.imgEl.src.replace("_on.gif", ".gif");
				currentmenu.imgEl.src = currentmenu.imgEl.src.replace("_on.png", ".png");
				currentmenu.className = currentmenu.className.replace(" on", "");
			} else {
				currentmenu.className = currentmenu.className.replace(" on", "");
			}
		}

		this.targetEl.style.display = "block";
		if (this.imgEl) {
			this.imgEl.src = this.imgEl.src.replace(".gif", "_on.gif");
			this.imgEl.src = this.imgEl.src.replace(".png", "_on.png");
			this.className += " on";
		} else {
			this.className += " on";
		}
		this.container.current = this;
	}
	return false;
}

// Tab Content02
function initTabMenu02(tabContainerID) {
	var tabContainer = document.getElementById(tabContainerID);
	var tabAnchor = tabContainer.getElementsByTagName("a");
	var i = 0;

	for(i=0; i<tabAnchor.length; i++) {
		if (tabAnchor.item(i).className == "tab")
			var thismenu = tabAnchor.item(i);
		else
			continue;

		thismenu.container = tabContainer;
		thismenu.targetEl = document.getElementById(tabAnchor.item(i).href.split("#")[1]);
		thismenu.targetEl.style.display = "none";
		thismenu.imgEl = thismenu.getElementsByTagName("img").item(0);
		if (thismenu.imgEl) {
			thismenu.onfocus = function () {
				//this.onfocus();
			}
		}
		thismenu.onclick = thismenu.onfocus = tabMenuOver;
		
		if (!thismenu.container.first)
			thismenu.container.first = thismenu;
	}
//tabContainer.first.onclick;
}
function initTabMenu03(tabContainerID) {
	var tabContainer = document.getElementById(tabContainerID);
	var tabAnchor = tabContainer.getElementsByTagName("a");
	var i = 0;

	for(i=0; i<tabAnchor.length; i++) {
		if (tabAnchor.item(i).className == "tab")
			var thismenu = tabAnchor.item(i);
		else
			continue;

		thismenu.container = tabContainer;
		thismenu.targetEl = document.getElementById(tabAnchor.item(i).href.split("#")[1]);
		thismenu.targetEl.style.display = "none";
		thismenu.imgEl = thismenu.getElementsByTagName("img").item(0);
		if (thismenu.imgEl) {
			thismenu.onfocus = function () {
				//this.onfocus();
			}
		}
		thismenu.onclick = tabMenuOver;
		
		if (!thismenu.container.first)
			thismenu.container.first = thismenu;
	}
	tabContainer.first.onclick();
}
function initTabMenusub(tabContainerID) {
	var tabContainer = document.getElementById(tabContainerID);
	var tabAnchor = tabContainer.getElementsByTagName("a");
	var i = 0;

	for(i=0; i<tabAnchor.length; i++) {
		if (tabAnchor.item(i).className == "tab")
			var thismenu = tabAnchor.item(i);
		else
			continue;

		thismenu.container = tabContainer;
		thismenu.targetEl = document.getElementById(tabAnchor.item(i).href.split("#")[1]);
		thismenu.targetEl.style.display = "none";
		thismenu.imgEl = thismenu.getElementsByTagName("img").item(0);
		if (thismenu.imgEl) {
			thismenu.onfocus = function () {
				//this.onfocus();
			}
		}
		thismenu.onfocus = tabMenuOver;
		thismenu.onclick = tabMenuOver;

		if (!thismenu.container.first)
			thismenu.container.first = thismenu;
	}
	tabContainer.first.onclick;
}

function tabMenuOversub() {
	var currentmenu = this.container.current;
	if (currentmenu != this) {
		if (currentmenu) {
			currentmenu.targetEl.style.display = "none";
			if (currentmenu.imgEl) {
				currentmenu.imgEl.src = currentmenu.imgEl.src.replace("_on.gif", ".gif");
				currentmenu.imgEl.src = currentmenu.imgEl.src.replace("_on.png", ".png");
				currentmenu.className = currentmenu.className.replace(" on", "");
			} else {
				currentmenu.className = currentmenu.className.replace(" on", "");
			}
		}
		
          this.targetEl.style.display = "block";
          if (this.imgEl) {
              this.imgEl.src = this.imgEl.src.replace(".gif", "_on.gif");
              this.imgEl.src = this.imgEl.src.replace(".png", "_on.png");
              this.className += " on";
          } else {
              this.className += " on";
          }
          this.container.current = this;
	}else{
			currentmenu.targetEl.style.display = "none";
			currentmenu.imgEl.src = currentmenu.imgEl.src.replace("_on.gif", ".gif");
			currentmenu.imgEl.src = currentmenu.imgEl.src.replace("_on.png", ".png");
			currentmenu.className = currentmenu.className.replace(" on", "");
	}
	initTabMenusubOn("cateMenu");
	return false;
}
function initTabMenusubOn(tabContainerID) {
	var tabContainer = document.getElementById(tabContainerID);
	var tabAnchor = tabContainer.getElementsByTagName("a");
	var i = 0;

	for(i=0; i<tabAnchor.length; i++) {
		if (tabAnchor.item(i).className == "tab on")
			var thismenu = tabAnchor.item(i);
		else 
			continue;

		thismenu.onfocus = tabMenuOversub;
		thismenu.onclick = tabMenuOversub;

		if (!thismenu.container.first)
			thismenu.container.first = thismenu;
	}
}