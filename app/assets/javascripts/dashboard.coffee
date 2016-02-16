today = new Date();
todayString = "#{today.getDate()}/#{today.getMonth()+1}/#{today.getFullYear()}";

hideForm = ->
  $(".order-placing-header").html("Choose a date")
  $('#order-form').hide()
  $('#order-form-loader').hide()

showForm = ->
  $(".order-placing-header").html("Place your order")
  $('#order-form').show()
  $('.order-total').html(0);

displayMenu = (date, options) ->
  hideForm();
  $('#order-form-loader').show();
  $.get(Routes.menu_path(encodeURIComponent(date)), options, 
    ->
      $('#order-form-loader').hide();
      showForm();
    , "script")

displayTodayMenu = (options) ->
  $.get(Routes.menu_path(encodeURIComponent(todayString)), options, null, "script")

displayOrderHistory = (date) ->
  $('#orders-history').hide();
  $('#order-history-loader').show();
  $.get(Routes.orders_history_path(encodeURIComponent(date)), null, 
    ->
      $('#orders-history').show();
      $('#order-history-loader').hide();
    , "script")

bindDatePicker = ->
  today = new Date();
  $('#day-selector').datepicker({
    endDate: todayString,
    todayBtn: "linked",
    autoclose: true,
    format: "dd/mm/yyyy",
    todayHighlight: true,
    daysOfWeekDisabled: "0,6",
    clearBtn: true
    });

#datepicker is used for multiple tabs
changeDate = ->
  selectedDate = $('#day-selector').val()
  if /^\d{2}\/\d{2}\/\d{4}$/.test(selectedDate)
    #if admin then tabs will exist
    if $("li.tab-bar.active").length
      $("li.tab-bar.active").attr("data-selected-date", selectedDate)
      switch $("li.tab-bar.active").data('tab')
        when "menu" then displayMenu(selectedDate, {html_container: "#menu-list", selectable: true});
        when "order-history" then displayOrderHistory(selectedDate);
    #else => just order form
    else
      displayMenu(selectedDate, {html_container: "#menu-list", selectable: true});
  else
    hideForm();

#update total price, when meal selected
handleMealSelection = ->
  $(document).on('change', '#menu-list input[type="radio"]',
    ->
      prices = $.map($('#menu-list input[type="radio"]:checked'), 
      (elem) ->
        return $(elem).closest('li').data('price'); 
      )
      total = 0;
      total += prices[i] for i in [0..prices.length-1]

      $('.order-total').html(total.toFixed(2));
  )

orderPageReady = ->
	bindDatePicker();

	$('#day-selector').change ->
    changeDate();

  handleMealSelection();

  #we need to remember date for each tab, that uses datepicker
  if gon.is_admin
    $('#tab-list li').click ->
      $('#tab-list li.active').removeClass('active')
      currentTabDate = $(this).attr("data-selected-date")
      $('#day-selector').val( if currentTabDate then currentTabDate else '').datepicker('update')
      #hide datepicker when we don't need it
      if $(this).data('tab') == "menu" or $(this).data('tab') == "order-history"
        $('#day-selector').closest('.input-group').show();
      else
        $('#day-selector').closest('.input-group').hide();
    #get today's order history
    displayOrderHistory(todayString);
    #get today's menu
    displayTodayMenu({html_container: "#today-menu", selectable: false});

  hideForm();
$(document).ready(orderPageReady)
$(document).on('page:load', orderPageReady)