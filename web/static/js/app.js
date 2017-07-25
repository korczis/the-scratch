require('font-awesome/css/font-awesome.css');
require('tether/dist/css/tether.css');
require('tether/dist/css/tether-theme-basic.css');
require('bootstrap/dist/css/bootstrap.css');

var csrf = document.currentScript.getAttribute('csrf');

var Elm = require('Main');
var node = document.getElementById('elm-app');
var app = Elm.Main.embed(node, { csrf: csrf});

/** Initialize JS Ports */
var  native = require('Native/Native');
native.initPorts(app);
