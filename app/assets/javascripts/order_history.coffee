$(document).on 'page:load ready', ->
  $('#order-date').datepicker
    todayBtn: "linked",
    autoclose: true,
    format: "dd-mm-yyyy",
    todayHighlight: true,
    daysOfWeekDisabled: "0,6",
    clearBtn: true
