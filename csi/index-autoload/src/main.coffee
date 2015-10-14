define ->
    firstTime = true
    ($sect, id)->
        ta = $sect.find 'textarea'
        if firstTime
            ta.val '''
                    This text is preloaded automaticaly
                    whether it was be active or not.
               '''
            alert 'first time'
            firtTime = false
