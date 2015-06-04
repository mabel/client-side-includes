        $locationsSelect = $panelFields.filter '[name=location]'
        $.get '/json/cabinet-ctrl-locations/table', (dat)->
            dat.forEach (el)->
                $ '<option>'
                    .attr 'value', el.id
                    .text el.name
                    .appendTo $locationsSelect
