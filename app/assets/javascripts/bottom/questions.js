$(document).on('click','#more',function () {
  var last_timestamp = $("#index-page").find(".question-summary").last().data('ts');
  $.getScript("/questions/more.js?last_timestamp=" + last_timestamp);
  $(this).text('loading...');
  return false;
});
