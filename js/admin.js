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
        bs_md:      'vendor/bootstrap-markdown',
        bs_tbl:     'vendor/bootstrap-table.min',
        bs_finp:    'vendor/fileinput.min',
        spin:       'lib/spin',
        csi:        'lib/csi',
        cms:        'lib/cms',
        css:        'lib/css',
        i18n:       'lib/i18n',
        validator:  'lib/validator',
    },

    shim: {
        backbone:  {deps: ['underscore']},
        validator: {deps: ['backbone']},
        i18n:      {deps: ['jquery']},
        bootstrap: {deps: ['jquery']},
        material:  {deps: ['bootstrap']},
        ripples:   {deps: ['bootstrap']},
        bs_md:     {deps: ['bootstrap']},
        bs_tbl:    {deps: ['bootstrap']},
        bs_finp:   {deps: ['bootstrap']},
        cms:       {deps: ['markdown']},
        css_list:  {deps: ['css']},
        csi:       {deps: ['material',  'ripples', 'spin', 'cms', 'bs_md', 'bs_tbl', 'bs_finp', 'validator']},
    },

})

define('css_list', ['css'], function(requireCss){
    [
	    'css/normalize',
	    'css/bootstrap.min',
	    'css/material-fullpalette.min',
	    'css/ripples.min',
	    'css/h5bp',
	    'css/correct',
	    'css/bootstrap-markdown.min',
        'css/bootstrap-table.min',
        'css/fileinput.min',
    ].forEach(function(el){requireCss(el)})
    require(['i18n'])
})

require(['spin', 'css_list'])
