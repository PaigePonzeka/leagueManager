//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function(){
  console.log("In the teams js");


  $("#roster-input").ajaxChosen({
      type: 'GET',
      url: '/users',
      dataType: 'json'
    }, function (data) {
      console.log('data');
      var results = [];

      $.each(data, function (i, val) {
        results.push({ value: val.value, text: val.text });
      });

      return results;
    });
});