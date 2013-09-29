//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready(function(){
   var teams_select  =  $('.js-teams-select');
   var division_select = $('.js-division-select');

  if(division_select.val()){
    updateTeam(division_select.val());
  }

  division_select.change(function(){
    var division_id = $(this).val();
    updateTeam(division_id);
  });

  $( ".js-datepicker" ).datetimepicker({
    dateFormat: 'M d, yy',
    timeFormat: 'hh:mm tt'
  });

  function createTitleOption() {
     var option = $("<option/>");
      option.text("Select Team");
      return option;
  }

  function updateTeam(division_id){
    $.ajax({
      url: "/get_teams_by_division",
      type: "GET",
      data: {"division_id" : division_id},
      dataType: "json",
      success: function(data) {
        console.log(data);
        teams_select.removeAttr('disabled');
        teams_select.html('');
        teams_select.append(createTitleOption)
        $.each(data, function(){
          var option = $("<option/>");
          option.attr('value', this.id).text(this.name);
          teams_select.append(option);
        });
      }
  });
  }
});