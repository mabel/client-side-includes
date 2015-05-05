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
                setTimeout (() ->
                    $alert.addClass 'hidden'
                ), 3000

            prefix = '.goods-editor-'

            descr =
                id:     {notEmpty: true,  filter: 'alphanum', event: 'focusout'}
                name:   {notEmpty: true,  filter: 'any',      event: 'focusout'}
                descr:  {notEmpty: false, filter: 'any',      event: 'focusout'}
                price:  {notEmpty: true,  filter: 'price',    event: 'focusout'}
                amount: {notEmpty: true,  filter: 'integer',  event: 'focusout'}
                type:   {notEmpty: true,  filter: '1|2|3',    event: 'change'}

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
                index = $rowDlg.data 'rowIndex'
                this.model.unset 'prev'
                this.model.unset 'edit'
                attrs = this.model.attributes
                ajaxSuccess = (dat) ->
                    if dat
                        dat = 'server_failure_' + dat
                        showResult dat
                        return
                    showResult()
                    if index > -1
                        $strTbl.bootstrapTable 'updateRow', {index: index, row: attrs}
                    else
                        $strTbl.bootstrapTable 'append', attrs

                ajaxFailure = (dat) ->
                    showResult 'server_error'
                $.post '/admin/goods/set', attrs, ajaxSuccess # , ajaxFailure

            goodsEdit = (e, value, row, index) ->
                getView = require 'validator'
                view = getView row, descr, $rowDlg, prefix, events
                $rowDlg.find '.goods-editor-id'
                    .prop 'disabled', (row.id != '!!!')
                $rowDlg.data 'rowIndex', index
                $rowDlg.modal()

            $sect.find '.btn-create'
                .click ()->
                    dat = {id: '!!!', name:'Новый товар', type: 0, price: 0, amount: 0}
                    goodsEdit null, null, dat, -1

            window.tableOfGoodsToolsEvents =
                'click .mdi-action-delete': (e, value, row, index) ->
                    if confirm 'Действительно удалить?'
                        $strTbl.bootstrapTable 'remove', {field: 'id', values: [row.id]}
                        $.get '/admin/goods/del/' + row.id
                'click .mdi-content-create': (e, value, row, index) ->
                    goodsEdit e, value, row, index

            $strTbl.bootstrapTable()
                .on 'load-success.bs.table', () ->
                    $strTbl.find '[data-toggle=popover]'
                        .popover()
            return

