define(function(){
	return function(href) {
		if(!/\.css$/.test(href)) href += '.css'
		var items = document.getElementsByTagName("link")
		for(var i = 0; i < items.length; i++) {
			if(items[i].getAttribute('href') === href) return	
		}
		var fileref=document.createElement("link")
		fileref.setAttribute("rel", "stylesheet")
		fileref.setAttribute("type", "text/css")
		fileref.setAttribute("href", href)
		document.getElementsByTagName("head")[0].appendChild(fileref)
	}
})

