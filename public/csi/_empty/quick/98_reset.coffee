        resetFormForAdd = (noId)->
            $fields.filter('input[name], textarea[name]').val ''
            $state
                .crutchCheckbox 'setChecked', false
            $submit.text 'Создать'
            getNewId() unless noId

