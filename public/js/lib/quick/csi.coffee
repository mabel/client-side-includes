define ['css', 'cms'], (loadCss, loadMd)->

    toLoad = []

    dataIsTrue = (div, attr)->
        ok = $(div).data attr
        return ok is true or ok is 'true'

    createPath = (id)->
        return '/csi/' + id + '/main.js'

    $ '[data-csi]'
        .each ()->
            id = $(@).data 'csi'
            $(@).attr 'id', id
            if $(@).is('nav') or (dataIsTrue @, 'csi-preload')
                path = createPath id
                toLoad.push path

    setActive = (anch)->
        $('.navbar-collapse li').removeClass 'active'
        $(anch).closest('.navbar-collapse > ul > li').addClass 'active'

    queueSection = (id)->
        id = id.substring 1
        $ '<section>'
            .attr 'id', id
            .attr 'data-csi', id
            .appendTo($ 'main')
        path = createPath id
        toLoad.push path

    createMenu = (sect)->
        $sect = $ sect
        $sect.find '[href^=#index-], [href^=#cabinet-], [href^=#admin-]'
            .click ()->
                $('section[data-csi]').each ()->
                    if $(@).not('[data-csi-preload=true]') then $(@).addClass 'hidden'
                    if $(@).not('[data-csi-preload=true]').not('[data-csi-cached=true]')  then $(@).empty()
                $('section.jumbotron').addClass('hidden').empty()
                id = $(@).attr 'href'
                queueSection id
                setActive @
        $.material.init()
        $('#spinner-wrap').remove()
        $('main').removeClass('hidden')
        hash = window.location.hash
        if /^#index-|#cabinet-|^#admin-/.test hash
            queueSection hash

    loadSection =  (path)->
        index = toLoad.indexOf path
        toLoad.splice index, 1
        loadCss path.replace /js$/, 'css'
        id = /(^\/csi\/)([^\/]+)(\/main\.js$)/.exec(path)[2]
        $ '#' + id
            .load path.replace(/js$/, 'html?r=' + Math.random()), ()->
                loadMd @
                if $(@).is 'nav' then createMenu @
                $(@).removeClass 'hidden'

    setInterval ()->
        toLoad.forEach (path)->
            if not require.defined(path) then require [path]
            else loadSection path
    , 100
    return (id)-> toLoad.push id
