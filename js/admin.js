requirejs.config({
  waitSeconds: 30,		
  baseUrl: '/js',
  paths: {
	jquery:	   'vendor/jquery-2.1.1.min',
	spinlib:   'vendor/spin.min',
	bootstrap: 'vendor/bootstrap.min',
	material:  'vendor/material.min',
	ripples:   'vendor/ripples.min',
	markdown:  'vendor/markdown.min',
	spin:      'lib/spin',
	csi:       'lib/csi',
	cms:       'lib/cms',
	css:       'lib/css',
  },

  shim: {
	bootstrap: {deps: ['jquery']},
	material:  {deps: ['bootstrap']},
	ripples:   {deps: ['bootstrap']},
	cms:       {deps: ['markdown']},
	css_list:  {deps: ['css']},
	csi:       {deps: ['material',  'ripples', 'spin', 'cms']},
  },

})

define('css_list', ['css'], function(requireCss){
    [
	    'css/normalize',
	    'css/bootstrap.min',
	    'css/material-fullpalette.min',
	    'css/ripples.min',
	    'css/h5bp',
    ].forEach(function(el){requireCss(el)})
    require(['csi'])
})

require(['spin', 'css_list'])
