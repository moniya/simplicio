(function () {
  function send(url, type) {
    $.ajax({
      url:url,
      type:type,
      data:{'follow_id': $("#profile-page").data('user')},
      dataType:'script'
    });
  }

  $("#follow-btn").click(function () {
    var action = $(this).data('action');

    if (action === 'follow') {
      send("/relationships", "POST");
      $(this).removeClass('btn-success')
             .addClass("disabled");
    }
    else {
      send("/relationships/remove", "DELETE");
      $(this).removeClass('btn-danger')
             .addClass("disabled");
    }
    return false;
  });

})();