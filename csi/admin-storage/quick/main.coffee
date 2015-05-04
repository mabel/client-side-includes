        id = 'admin-storage'
        csi = require 'csi'
        if csi[id]
            return
        csi[id] = (sect) ->
            $sect = $ sect
            $strTbl = $sect.find 'table'
                .removeClass 'hidden'
            $rowDlg = $sect.find '.modal'
            goodsTypes =
                '1': 'Безопасн.'
                '2': 'Энергосбер.'
                '3': 'Комфорт'
            $typesSelect = $rowDlg.find 'select'
            _.each goodsTypes, (val, key) ->
                $('<option>').attr 'value', key
                    .text val
                    .appendTo $typesSelect
            window.tableOfGoodsPreviewFormatter = (value, row, index)  ->
                descr = row.descr
                if !descr
                    descr = 'Нет описания.'
                $sect.find '.preview'
                    .clone()
                    .removeClass 'hidden'
                    .html()
                    .replace('preview', row.id)
                    .replace('No description', markdown.toHTML descr)
            window.tableOfGoodsToolsFormatter = (value, row, index)  ->
                '<div class="row-tools"><i class="mdi-content-create"></i></div>' +
                '<div class="row-tools"><i class="mdi-action-delete"></i></div>'
            window.tableOfGoodsTypesFormatter = (value, row, index)  ->
                goodsTypes[value]
            $prev = $sect.find '#goods-preview'
            $idField = $sect.find '.row-editor-id'
            $sect.find '[href=#goods-preview]'
                .click () ->
                    $prev.empty()
                    $file = $ '<input type="file">'
                        .attr 'name', $idField.val()
                        .appendTo $prev
                        .fileinput
                            uploadUrl: '/admin/goods/upload'
                    id = $rowDlg.find '.goods-editor-id'
                        .val()
                    $dz = $prev.find '.file-drop-zone'
                    url = '/img/goods/' + id + '.png'
                    $.get url, () ->
                        $dz.css
                            'background-image': 'url("' + url + '")'
            $sect.find '.btn-create'
                .click ()->
                    $strTbl.bootstrapTable 'append', {id: '!!!', name:'Новый товар', type: 0, price: 0, amount: 0}

