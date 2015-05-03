        id = 'admin-storage'
        csi = require 'csi'
        if csi[id]
            return
        csi[id] = (sect) ->
            $sect = $ sect
            $usrTbl = $sect.find 'table'
                .removeClass 'hidden'
            $rowDlg = $sect.find '.modal'
            window.tableOfGoodsToolsFormatter = (value, row, index)  ->
                '<div class="row-tools"><i class="mdi-content-create"></i></div>'
            # window.tableOfGoodsToolsEvents =
            #    'click .mdi-content-create': (e, value, row, index) ->
            #        $rowDlg.modal()
            # $usrTbl.bootstrapTable()
            $prev = $sect.find '#goods-preview'
            $idField = $sect.find '.row-editor-id'
            $sect.find '[href=#goods-prewiew]'
                .click () ->
                    $prev.empty()
                    $file = $ '<input type="file">'
                        .attr 'name', $idField.val()
                        .appendTo $prev
                        .fileinput
                            uploadUrl: '/admin/upload/goods'

