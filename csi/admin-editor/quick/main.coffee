        csi = require 'csi'
        if csi['admin-editor']
            return
        csi['admin-editor'] = (sect) ->
            $sect = $(sect)
            $ta = $sect.find 'textarea'
            $file = $sect.find 'input'
            $files = $sect.find 'select'
            $ta.markdown
                savable: true
                language: 'ru'
                onSave: (e) ->
                    file = $file.val().trim()
                    if !/^[a-z0-9_]{3,}$/.test file
                        alert 'Укажите имя файла.'
                        return
                    content = e.getContent().trim()
                    if !content
                        alert 'Нечего сохранять. Напишите что-нибудь.'
                        return
                    if !/^#/.test content
                        alert('В начале текста должен быть заголовок. Используйте знак #.')
                        return
                    dat = {content: content, file: file}
                    $.post '/edit/save/texts', dat, (repl) ->
                        alert repl
            $prevBtn = $sect.find '.btn-toolbar .btn-group:last button'
                .text ''
                .append '<span class="glyphicon glyphicon-search"></span> Предпросмотр'
            $saveBtn = $sect.find '.md-footer button'
            $saveBtn.removeClass 'btn-success'
                .addClass 'btn-primary'
                .text ''
                .append '<span class="glyphicon glyphicon-cloud-upload"></span> Сохранить'
            return
