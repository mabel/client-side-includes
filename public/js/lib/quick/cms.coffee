define ()->
    (div)->
        mds = $(div).find '[data-md]'
        cnt =  mds.length
        id  = $(div).data 'csi'
        after = ()->
            path = '/csi/' + id + '/main.js'
            fn = require path
            if typeof fn is 'function' then fn div, id
        if not cnt then after(); return
        $(mds).each ()->
            el = this
            md = '/cms/' + $(this).data('md') + '.md?r=' + Math.random()
            $.get md, (dat)->
                $(el).html window.markdown.toHTML(dat.trim())
                if not --cnt then after()

