(function () {
  $(document).delegate('#new_answer', 'submit', function (e) {
    var self = $(e.target),
        textarea = self.find("#answer_text");

    if ($.trim(textarea.val()) == "") {
      return;
    }
    $(this).find('.btn')
        .attr({value:'Please wait...', disabled:true});
  });
})();