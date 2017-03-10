'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/fond-awesome.css');

// Require inext.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode);
