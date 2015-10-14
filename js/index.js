requirejs.config({
	waitSeconds: 30,	
	baseUrl: 'js',
	paths: {
        jquery:    'vendor/jquery-2.1.4.min',
        bootstrap: 'vendor/bootstrap.min',
        ripples:   'vendor/ripples.min',
        material:  'vendor/material.min',
        spinlib:   'vendor/spin.min',
        dropdown:  'vendor/dropdown.min',
		spin:      'modules/spin',
		css:       'modules/css',
		init:      'modules/init',
		nav:       'modules/init',
		sect:      'modules/sect',
	},

    shim: {
        bootstrap: {deps: ['jquery']},
        material:  {deps: ['bootstrap']},
        ripples:   {deps: ['material']},
        init:      {deps: ['ripples', 'dropdown']},
    }
})

window.cssBundles = {
    index: [
        "css/h5bp.css",
        "css/bootstrap.min.css",
        "css/roboto.min.css",
        "css/material-fullpalette.min.css",
        "css/ripples.min.css",
        "css/jquery.dropdown.css",
    ]
}

require(['init'])
