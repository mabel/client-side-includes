// Client side includes

define(['css', 'cms'], function(requireCss, setSlices){
    $nav = $('nav')
    var id = $nav.data('csi')
    var csiFunctions = {}
    loadSection(id, requireCss, setSlices)
    return csiFunctions
})

function loadSection(id, requireCss, setSlices){
    var path = '/csi/' + id + '/main'
    requireCss(path)
    $('[data-csi=' + id + ']').load(path + '.html' + '?r=' + Math.random(), function(){
        setSlices(this)
        if(!$(this).is('nav')) return
        $(this).find('[href^=#index-], [href^=#cabinet-], [href^=#admin-]').click(function(){
            $('section[data-csi]').addClass('hidden').empty()
            $('section.jumbotron').addClass('hidden').empty()
            var id = $(this).attr('href').substring(1)
            loadSection(id, requireCss, setSlices)
            $('section[data-csi=' + id + ']').removeClass('hidden')
        })
        $(this).find('[href^=#cms-]').click(function(){
            $('section[data-csi]').addClass('hidden').empty()
            $('section.jumbotron').addClass('hidden').empty()
            var href = $(this).attr('href').replace(/[-#]/g, '/') + '.md?r=' + Math.random()
            $.get(href, function(dat){
                var html = markdown.toHTML(dat)
                $('.jumbotron').html(html).removeClass('hidden')
            })
        })
        setTimeout(function(){
            $.material.init();
            if(require.defined('spin')){
                require('spin').stop()
                $('#spinner-wrap').remove()
            }
            $('main, nav').removeClass('hidden')
        }, 100)
    })
}
