            prefix = '.goods-editor-'
            descr =
                id:     {notEmpty: true,  filter: 'alphanum', event: 'focusout'}
                name:   {notEmpty: true,  filter: 'any',      event: 'focusout'}
                descr:  {notEmpty: false, filter: 'any',      event: 'focusout'}
                price:  {notEmpty: true,  filter: 'price',    event: 'focusout'}
                amount: {notEmpty: true,  filter: 'integer',  event: 'focusout'}
                type:   {notEmpty: true,  filter: '1|2|3',    event: 'change'}
                index:  {notEmpty: true,  filter: 'int'}

            events = {}
            _.each descr, (val, key) ->
                if !val.event
                    return
                events[val.event + ' ' + prefix + key] = () ->
                    this.setFromField key

            events['click .btn-save'] = () ->
                if !this.model.isValid()
                    showResult this.model.validationError
                    return
                attrs = this.model.attributes
                ajaxSuccess = (dat) ->
                    if dat
                        dat = 'server_failure_' + dat
                        showResult dat
                        return
                    showResult()
                    if attrs.isNew
                        delete attrs.isNew
                        $strTbl.bootstrapTable 'append', attrs
                        return
                    $strTbl.bootstrapTable 'updateRow', {index: attrs.index, row: attrs}
                ajaxFailure = (dat) ->
                    showResult 'server_error'
                $.post '/admin/goods/set', attrs, ajaxSuccess, ajaxFailure

            $alertSuccess = $rowDlg.find '.alert-success'
            $alertDanger  = $rowDlg.find '.alert-danger'
            $errMessage   = $alertDanger.find 'strong'

            showResult = (err) ->
                $alert = $alertSuccess
                if err
                    $alert = $alertDanger
                    $errMessage.attr 'data-i18n-text', err
                    $alert.i18n()
                $alert.removeClass 'hidden'
                setTimeout (() -> $alert.addClass 'hidden'), 3000

            window.tableOfGoodsToolsEvents =
                'click .mdi-action-delete': (e, value, row, index) ->
                    if confirm 'Действительно удалить?'
                        $strTbl.bootstrapTable 'remove', {field: 'id', values: [row.id]}
                        $.get '/admin/del/str/' + row.id
                'click .mdi-content-create': (e, value, row, index) ->
                    getView = require 'validator'
                    view = getView row, descr, $rowDlg, prefix, events
                    view.model.set 'index', index
                    $rowDlg.find '.goods-editor-id'
                        .prop 'disabled', row.id !== '!!!'
                    $rowDlg.modal()

            $strTbl.bootstrapTable()
            $strTbl.find '[data-toggle=popover]'
                .popover
                    placement: 'bottom'
            return

