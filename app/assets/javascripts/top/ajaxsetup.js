jQuery(function ($) {
  $.ajax({
    cache:false
  });

  $(document)
      .bind("ajax:error", function (event, jqXHR, ajaxSettings, thrownError) {
        console.log(event);
        console.log(jqXHR);
        console.log(ajaxSettings);
        console.log(thrownError);

        if (jqXHR.status == 401) {
          alert(JSON.parse(jqXHR.responseText).message);

        }
        else if (jqXHR.status == 422) {
          alert(JSON.parse(jqXHR.responseText).message);

        } else if (jqXHR.status == 0) {
          alert("Your Internet connection appears to be offline.");
        }
        else {
          //console.log(jqXHR.status);
        }

        var btn = $(event.target).find('.btn'),
            origText = btn.data('text');
        btn.attr({disabled:false, value:origText});
      });


});
