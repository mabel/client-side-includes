        id = 'admin-users'
        csi = require 'csi'
        if csi[id]
            return

        ###
        window.tableOfGroupsEvents = {
            'click .mdi-content-create': function (e, value, row, index) {
                $.each(row, function(key, val){
                    $grpDlg.find('.change-group-of-slots-' + key).val(val)
                    $radio = $grpDlg.find('[name=change-group-of-slots-' + key + ']')
                    if($radio.length) $radio.filter('[value=' + val + ']').prop('checked', true)
                })
                $grpDlg.data('row', row)
                $grpDlg.data('index', index)
                $grpDlg.data('grploc', [])
                $.get('/locations/of/group?gid=' + row.grp, function(dat){
                    $locTbl.bootstrapTable('uncheckAll')
                    $.each(dat, function(key, val){
                        $locTbl.bootstrapTable('checkBy', {field: 'loc', values: [val.lid]})
                    })
                })
                $grpDlg.modal()
            },
        }
        ###
        csi[id] = (sect) ->
            $sect = $ sect
            $usrTbl = $sect.find 'table'
                .removeClass 'hidden'
            $rowDlg = $sect.find '.row-editor'
            window.tableOfUsersToolsFormatter = (value, row, index)  ->
                '<div class="row-tools"><i class="mdi-content-create"></i></div>'
            window.tableOfUsersToolsEvents =
                'click .mdi-content-create': (e, value, row, index) ->
                    $rowDlg.modal()
            $usrTbl.bootstrapTable()
            return
