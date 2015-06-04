define ()->
    targets =
        TEST: (json)-> if false then alert json.msg
    $.get '/json/wskey', (dat)->
        window.WebSocket = window.WebSocket || window.MozWebSocket
        if not window.WebSocket then alert 'К сожалению, Ваш браузер не поддерживает Websocket'; return
        host = window.location.hostname
        connection = new WebSocket 'ws://' + host + ':4011/'
        # connection = new WebSocket 'ws://' + host + '/ws/'
        connection.onmessage = (message)->
            json   = JSON.parse(message.data)
            target = json.target
            if target is 'wscheck'
                connection.send JSON.stringify wskey: dat
                return
            if typeof targets[target] isnt 'function' then return
            targets[target](json)
        connection.onclose = ()->
            if confirm 'Соединение с сервером прервалось. Перезагрузить страницу для восстановления?'
                window.top.location.reload()
    return targets

