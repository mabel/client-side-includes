        checkFormForAdd = ()->
            name = $panelName.val().trim()
            if not name then alert 'Укажите наименование.'; return false
            if not $locationsSelect.val() then alert 'Выберите локацию.'; return false
            nameIsInUse = false
            idIsNew = true
            id = $panelId.val()
            dat = $mainTable.bootstrapTable 'getData'
            dat.forEach (el)->
                nameIsInUse = el.name is name
                idIsNew &= id isnt el.id
            if idIsNew and nameIsInUse then alert 'Строка с таким именем уже есть в таблице.'; return false
            true

        $panelSubmit.click ()->
            return if not checkFormForAdd()
            row = {}
            $panelFields.filter 'input, textarea, select'
                .each ()->
                    key = $(@).attr 'name'
                    val = $(@).val()
                    row[key] = "#{val}".trim()
            if confirm JSON.stringify row
                $.post "/json/#{sectionId}/set", row, (dat)->
                    alert dat

