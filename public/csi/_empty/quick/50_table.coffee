        setField = (key, val)->
            $fields.filter "[name='#{key}']"
                .val val

        window["#{sectionId}-state-formatter"] = (value, row, index)->
            return '<i class="mdi-toggle-check-box"></i>' if value is 'true' or value is true
            '<i class="mdi-toggle-check-box-outline-blank"></i>'

        window["#{sectionId}-tools-formatter"] = (value, row, index)->
            '<i class="mdi-content-create"></i> &nbsp; <i class="mdi-action-delete"></i>'

        window["#{sectionId}-tools-events"] =
            'click .mdi-content-create': (e, value, row, index)->
                setField k, v for k, v of row
                $state.crutchCheckbox 'setChecked', (row.state is 'true' or row.state is true)
                $submit.text 'Сохранить'
                return false
            'click .mdi-action-delete': (e, value, row, index)->
                if not confirm 'Действительно удалть?' then return false
                $.get "/json/#{sectionId}/del/" + row.id, ()->
                    $table.bootstrapTable 'refresh'

        $mainTable.bootstrapTable()
