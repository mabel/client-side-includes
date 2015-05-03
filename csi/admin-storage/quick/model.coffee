            window.tableOfGoodsToolsEvents =
                'click .mdi-content-create': (e, value, row, index) ->
                    prefix = '.goods-editor-'
                    descr =
                        id:     {notEmpty: true, filter: 'alphanum', event: 'focusout'}
                        name:   {notEmpty: true, filter: 'any', event: 'focusout'}
                        type:   {notEmpty: true, filter: 'alphanum', event: 'change'}
                        price:  {notEmpty: true, filter: 'price', event: 'focusout'}
                        amount: {notEmpty: true, filter: 'integer', event: 'focusout'}
                    events = {}
                    _.each descr, (val, key) ->
                        events[val.event + ' ' + prefix + key] = () ->
                            this.setFromField key

                    events['click .btn-save'] = () ->
                            alert JSON.stringify(this.model.attributes)

                    view = require('validator')({id: 12345, name: 'HZ', type: 3}, descr, $rowDlg, prefix, events)
                    $rowDlg.modal()

                    ###
                    $success = $rowDlg.find '.alert-success'
                    $danger  = $rowDlg.find '.alert-danger'
                    $errMsg  = $danger.find 'strong'
                    RowView  = Backbone.View.extend({
                        el: $rowDlg[0]
                        setFromField: (key) ->
                            this.model.set key, this.$el.find('.goods-editor-' + key).val()
                        events:
                            'focusout .goods-editor-id': () ->
                                this.setFromField('id')
                            'focusout .goods-editor-name': () ->
                                this.setFromField('name')
                            'focusout .goods-editor-price': () ->
                                this.setFromField('price')
                            'focusout .goods-editor-amount': () ->
                                this.setFromField('amount')
                            'change .goods-editor-type': () ->
                                this.setFromField('type')
                            'click .btn-save': () ->
                                $alert = $success
                                if !this.model.isValid()
                                    $errMsg.text this.model.validationError
                                    $alert = $danger
                                $alert.removeClass 'hidden'
                                setTimeout (() -> $alert.addClass 'hidden'), 3000
                    })

                    rowView = new RowView
                        model: model
                    ###
            $usrTbl.bootstrapTable()
            return

