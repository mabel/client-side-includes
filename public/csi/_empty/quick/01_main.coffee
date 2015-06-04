define ()->
    (sect, sectionId)->
        $sect      = $ sect
        $state     = $sect.find     "##{sectionId}-state"
        if $state.length
            $state
                .crutchCheckbox
                    checkedLabel:   'вкл.'
                    uncheckedLabel: 'откл.'
                    checked:        false
                    name:           'state'
        $panel        = $sect.find  '.panel'
        $allFields    = $sect.find  'input[name], textarea[name], select[name]'
        $panelFields  = $panel.find 'input[name], textarea[name], select[name]'
        $allButtons   = $sect.find  'a[name], button[name]'
        $panelButtons = $panel.find 'a[name], button[name]'
        $panelId      = $panelFields.filter  '[name=id]'
        $panelName    = $panelFields.filter  '[name=name]'
        $panelSubmit  = $panelButtons.filter '[name=submit]'
        $mainTable    = $sect.find "##{sectionId}-table-main"

        getNewId = ()->
            $.get '/json/newid', (dat)->
                $panelId.val dat
        getNewId()

