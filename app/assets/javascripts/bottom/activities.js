(function () {
  $("#more-feed").on('click', function () {
    var last_timestamp = $("#feed-page").find(".stream-item").last().data('ts');
    $.getScript("/activities/more.js?last_timestamp=" + last_timestamp);
    $(this).text('loading...');
    return false;
  });
})();