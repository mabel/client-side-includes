define(function(){

	var words = {}

	function loadLang(lng){
		$.get('/i18n/' + lng + '.txt', function(data){

			var sa = data.split(/[\r\n]/)

			for(i in sa){
				var saa = sa[i].split('=')
				if(!saa || saa.length < 2) continue
				var key = saa[0].trim()
				var val = saa[1].trim()
				words[key] = val
			}

			$.fn.i18n = function(){
			  $(this).find('[data-i18n-title], [data-i18n-text], [data-i18n-placeholder]').each(function(){
				  var key = $(this).attr('data-i18n-title') || $(this).attr('data-i18n-text') || $(this).attr('data-i18n-placeholder')
				  var val = words[key] || key
				  if($(this).attr('data-i18n-title'))       $(this).attr('title',       val).attr('data-title', val)	
				  if($(this).attr('data-i18n-placeholder')) $(this).attr('placeholder', val)	
				  if($(this).attr('data-i18n-text'))        $(this).text(val)	
			  })
			  return this
			}
			$(function(){$('body').i18n()})
			setTimeout(function(){
				require(['csi'])
			}, 300)
		}).fail(function(){loadLang('en')})
	}

	var language = window.navigator.userLanguage || window.navigator.language;
	language = language.trim().match(/^[a-z]{2}/)[0]
	loadLang(language)
	
})


