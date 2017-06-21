$(document).on 'page:load ready', ->
  $('#menu-date').datepicker
    todayBtn: "linked",
    autoclose: true,
    format: "dd-mm-yyyy",
    todayHighlight: true,
    daysOfWeekDisabled: "0,6",
    clearBtn: true

$(document).on 'change', '#menu-list input[type="radio"]', ->
  prices = $.map($('#menu-list input[type="radio"]:checked'), (elem) ->
    parseFloat($(elem).closest('li').data('price')))

  total = 0;
  total += prices[i] for i in [0..prices.length-1]

  $('.order-total').html(total.toFixed(2))
