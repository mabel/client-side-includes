define(function(){
	return function(div){
		var mds = $(div).find('[data-md]')
		var cnt =  mds.length
        var id = $(div).data('csi')
        var after = require.defined(id) ? require(id) : null
		if(!cnt && after) after()
		$(mds).each(function(){
			var el = this
			var md = '/cms/' + $(this).data('md') + '.md?r=' + Math.random()
			$.get(md, function(dat){
        		$(el).html(window.markdown.toHTML(dat.trim()))
				if(!--cnt && after) after()
			})
		})
	}
})
