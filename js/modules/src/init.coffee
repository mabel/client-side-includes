define ['spinlib', 'css'], (Spinner, loadCss)->
    spinOpts =
        lines:      13,         # The number of lines to draw
        length:     20,         # The length of each line
        width:      10,         # The line thickness
        radius:     30,         # The radius of the inner circle
        corners:    1,          # Corner roundness (0..1)
        rotate:     0,          # The rotation offset
        direction:  1,          # 1: clockwise, -1: counterclockwise
        color:      '#000',     # #rgb or #rrggbb or array of colors
        speed:      1,          # Rounds per second
        trail:      60,         # Afterglow percentage
        shadow:     false,      # Whether to render a shadow
        hwaccel:    false,      # Whether to use hardware acceleration
        className:  'spinner',  # The CSS class to assign to the spinner
        zIndex:     2e9,        # The z-index (defaults to 2000000000)
        top:        '50%',      # Top position relative to parent
        left:       '50%'       # Left position relative to parent

    page = 'index'
    if /cabinet/.test window.top.location then page = 'cabinet'
    if /admin/.test   window.top.location then page = 'admin'

    getActiveSectionId = ()->
        hash = window.location.hash.trim().replace /csi-/, ''
        if not hash or not $("#{hash}").length
            hash = $('nav li.active a').attr('href').replace /csi-/, ''
        return hash.substring 1

    setActiveSection = (id)->
        $('nav .navbar-collapse > ul > li').removeClass 'active'
        $anch = $ "nav a[href=#csi-#{id}]"
        $anch.closest('nav .navbar-collapse > ul > li').addClass 'active'
        $("##{id}").removeClass 'hidden'

    loadSection = (id, after)->
        prefix = "/csi/#{page}-#{id}/main."
        loadCss "#{prefix}css"
        if id is 'nav' then $sect = $ 'nav'
        else $sect = $ "##{id}"
        if $sect.length is 0
            $sect = $ '<section>'
                .attr 'id', id
                .addClass 'hidden'
                .appendTo $ 'main'
        $sect.load "#{prefix}html?#{Math.random()}", ->
            require ["#{prefix}js"], (func)->
                if typeof func  is 'function' then func  $sect, id
                if typeof after is 'function' then after $sect, id

    postNav = ->
        $.material.init()
        $(".select").dropdown({ "autoinit" : ".select" })
        spinner.stop()
        $('nav, main').removeClass 'hidden'
        $('section').addClass('hidden').data 'csi-cached', true
        $('section[data-csi-autoload=true]').each ->
            id = $(@).attr 'id'
            if id is getActiveSectionId() then return # Will be loaded at end of function.
            loadSection id
        $ 'nav a[href^=#csi-]'
            .click ->
                $('section').addClass('hidden').each ->
                    if not $(@).data 'csi-cached' then $(@).empty()
                id = $(@).attr('href').replace /#csi-/, ''
                $sect = $ "##{id}"
                if $sect.data('csi-cached') and $sect.is ':not(:empty)'
                    setActiveSection id
                    return
                loadSection id, -> setActiveSection id
        id = getActiveSectionId()
        loadSection id, -> setActiveSection id

    spinner = new Spinner spinOpts
        .spin document.body
    $('nav, main').addClass 'hidden'
    window.cssBundles[page].forEach (el)->
            loadCss el
    loadSection "nav", postNav
    return null
