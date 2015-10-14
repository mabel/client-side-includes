define ->
    (href)->
        links = document.getElementsByTagName("link")
        for link in links
            if href is link.getAttribute 'href' then return
        link = document.createElement "link"
        link.setAttribute "rel",  "stylesheet"
        link.setAttribute "type", "text/css"
        link.setAttribute "href", href
        document.getElementsByTagName("head")[0].appendChild link
