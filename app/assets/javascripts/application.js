// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.cookie-1.3.1
//= require bootstrap-sprockets
//= require jquery.navgoco.0.2.1
//= require_tree .
//= require cocoon
//= require algolia/algoliasearch.min
//= require select2
//= require select2_locale_fr

$(document).ready(function() {
    // Initialize navgoco with default options
    $("#accordion").navgoco({
        cookie: {
            name: 'navgoco',
            expires: false,
            path: '/'
        }
    });

    $(".collapseAll").click(function(e) {
        e.preventDefault();
        $("#accordion").navgoco('toggle', false);
    });
    $(".expandAll").click(function(e) {
        e.preventDefault();
        $("#accordion").navgoco('toggle', true);
    });
});