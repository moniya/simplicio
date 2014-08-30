(function () {
  $('#answers').on('click', '#comment-btn', function () {
    var self = $(this);
    if ($.trim(self.siblings('textarea').val()) === "") {
      return false;
    }
  });

  $('#answers').on('submit', '.new_comment', function () {
    $(this).find('.btn')
        .attr({value:'Please wait...', disabled:true});
  });
})();