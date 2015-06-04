requirejs.config({

    waitSeconds: 30,		
    baseUrl: '/js',

    paths: {
        underscore: 'vendor/underscore-min',
        backbone:   'vendor/backbone-min',
        jquery:	    'vendor/jquery-2.1.1.min',
        spinlib:    'vendor/spin.min',
        bootstrap:  'vendor/bootstrap.min',
        material:   'vendor/material.min',
        ripples:    'vendor/ripples.min',
        markdown:   'vendor/markdown.min',
        bs_tbl:     'vendor/bootstrap-table.min',
        bs_dtp:     'vendor/bootstrap-datetimepicker.min',
        bs_spin:    'vendor/jquery.bootstrap-touchspin.min',
        bs_snack:   'vendor/snackbar.min',
        moment:     'vendor/moment-with-locales',
        cytoscape:  'vendor/cytoscape.min',
        spin:       'lib/spin',
        csi:        'lib/csi',
        cms:        'lib/cms',
        css:        'lib/css',
        i18n:       'lib/i18n',
        crutches:   'lib/crutches',
        validator:  'lib/validator',
        websocket:  'lib/websocket',
    },

    shim: {
        backbone:  {deps: ['underscore']},
        validator: {deps: ['backbone']},
        i18n:      {deps: ['jquery']},
        bootstrap: {deps: ['jquery']},
        crutches:  {deps: ['jquery']},
        cytoscape: {deps: ['jquery']},
        websocket: {deps: ['jquery']},
        material:  {deps: ['bootstrap']},
        ripples:   {deps: ['bootstrap']},
        bs_dtp:    {deps: ['bootstrap', 'moment']},
        bs_tbl:    {deps: ['bootstrap']},
        bs_spin:   {deps: ['bootstrap']},
        bs_snack:  {deps: ['bootstrap']},
        cms:       {deps: ['markdown']},
        css_list:  {deps: ['css']},
        csi:       {deps: [
            'material',  
            'ripples', 
            'spin', 
            'cms', 
            'bs_snack', 
            'bs_dtp', 
            'bs_tbl', 
            'bs_spin', 
            'validator',
            'websocket',
            'crutches'
          /*  'cytoscape' */
        ]},
    },

})

define('css_list', ['css'], function(requireCss){
    [
	    'css/normalize',
	    'css/bootstrap.min',
	    'css/material-fullpalette.min',
	    'css/ripples.min',
	    'css/h5bp',
	    'css/crutch',
	    'css/bootstrap-markdown.min',
        'css/bootstrap-table.min',
        'css/bootstrap-datetimepicker.min',
        'css/jquery.bootstrap-touchspin.min',
        'css/snackbar.min',
        'css/gsm2biz',
    ].forEach(function(el){requireCss(el)})
    require(['i18n'])
})

require(['spin', 'css_list'])
