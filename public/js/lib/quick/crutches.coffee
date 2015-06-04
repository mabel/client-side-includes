(($)->
    $.fn.crutchLabel = (type, text, time)->
        if arguments.length < 2 then return
        $(@).html "<span class=\"label label-#{type}\">#{text}</span>"
        if not time then return
        if time
            setTimeout ->
                    $(@).empty()
                , time < 1000 ? time * 1000 : time
        return @
    $.fn.crutchAlert = (type, head, body, time)->
        if not $(@).data 'alerts'
            obj = {}
            setDiv = (t)->
                obj[t] = $ '<div class="alert alert-dismissable">'
                    .addClass "alert-#{t}"
                    .append  '<button type="button" class="close" data-dismiss="alert">×</button>'
                    .append  '<h4>'
                    .append  '<p>'
            setDiv t for t in ['warning', 'danger', 'success', 'info']
            $(@).data 'alerts', obj
        if not arguments or not arguments.length then return
        $(@).empty()
        alerts = $(@).data 'alerts'
        $alert = alerts[type]
        $alert.find('h4').text head
        $alert.find('p').text body
        $alert.appendTo @
        if time
            setTimeout ->
                    $alert.remove()
                , time < 1000 ? time * 1000 : time
        return @

    $.fn.crutchRadioSet = (selector, options)->
        $root = $ @
        classPrefix = 'mdi-toggle-radio-button-'
        setChecked = (div)->
            val = $(div).data 'radioValue'
            $root.find 'i'
                .each ()->
                    yo = $(@).closest('.crutch-checkbox').data('radioValue') is val
                    $ @
                        .removeClass classPrefix + (if yo then 'off' else 'on')
                        .addClass classPrefix + (if yo then 'on' else 'off')
                    if yo then $root.data 'radioValue', val
        if not options or typeof options isnt 'object'
            todo = selector
            val = options
            switch todo
                when 'reset'
                    $root.find '.crutch-checkbox i'
                        .each ()->
                            $ @
                                .removeClass classPrefix + 'on'
                                .addClass classPrefix + 'off'
                    $root.data 'radioValue', null
                when 'setValue'
                    $root.find '.crutch-checkbox'
                        .each ()->
                            if  val is $(@).data 'radioValue'
                                setChecked @
                    return
                when 'getValue'
                    dat = $root.data 'radioValue'
                    return dat
            return
        createRadio = (div, i)->
            params = options[i]
            $(div).addClass('crutch-checkbox')
            $bh = $('<div>').addClass('crutch-checkbox-box').appendTo(div)
            $lh = $('<div>').addClass('crutch-checkbox-label').appendTo(div)
            $i  = $('<i>').addClass(classPrefix + (if params.checked then 'on' else 'off')).appendTo($bh)
            $l  = $('<label>').text(params.label).appendTo($lh)
            $(div).data 'radioValue', params.value
            $(div).click ()->
                setChecked @
                return
        createRadio div, i for div, i in $root.find selector
        return @

    $.fn.crutchCheckbox = (arg1, arg2)->
        $div = $ this
        defaults =
            checked: false
            checkedStyle: 'mdi-toggle-check-box'
            uncheckedStyle: 'mdi-toggle-check-box-outline-blank'
            label: ''
            checkedLabel: ''
            uncheckedLabel: ''
        setChecked = (ch)->
            settings = $div.data 'settings'
            ch = ch is true or ch is 'true'
            $i = $div.find 'i'
            $l = $div.find 'label'
            $h = $div.find 'input'
            $i.removeClass settings.checkedStyle
            $i.removeClass settings.uncheckedStyle
            if ch
                $i.addClass settings.checkedStyle
                $l.text settings.checkedLabel
            else
                $i.addClass settings.uncheckedStyle
                $l.text settings.uncheckedLabel
            $h.val ch
            $div.data 'checked', ch
            fn = $div.data 'change'
            if typeof fn is 'function' then fn ch
        if typeof arg1 is 'undefined' then arg1 = {}
        if typeof arg1 is 'object'
            settings = $.extend defaults, arg1
            if settings.label
                settings.checkedLabel   = settings.label
                settings.uncheckedLabel = settings.label
            $div.data 'settings', settings
            $div.data 'checked', settings.checked
            $div.addClass 'crutch-checkbox'
            $bh = $('<div>').addClass('crutch-checkbox-box').appendTo($div)
            $lh = $('<div>').addClass('crutch-checkbox-label').appendTo($div)
            $('<i>').appendTo $bh
            $('<label>').appendTo $lh
            $h = $('<input type="hidden">').appendTo($div)
            if settings.name then $h.attr 'name', settings.name
            $div.click ()->
                setChecked not $div.data 'checked'
            setChecked settings.checked
            if typeof settings.change is 'function'
                $div.data 'change', settings.change
            return @
        switch arg1
            when 'setChecked' then setChecked arg2
            when 'isChecked'  then return $div.data 'checked'
) @.jQuery
