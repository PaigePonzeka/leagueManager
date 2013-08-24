//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



$(document).ready(function(){

  $('.js-remove-player').click(function(e){
      e.preventDefault();
      $.ajax({
            url: "test.html",
            cache: false
          }).done(function( html ) {
          $("#results").append(html);
        });
    });
});