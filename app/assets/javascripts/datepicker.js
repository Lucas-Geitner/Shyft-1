$(document).ready(function() {
  $('.datepicker').datepicker({
    language: "fr",
    format: "yyyy-mm-dd",
    weekStart: 1,
    autoclose: true,
    todayHighlight: true,
    startDate: new Date()
  });
})
