$(function () {
  var toggleComments = '.toggle-comments',
      commentTextarea = '.comment-entry textarea',
      toggleTextarea = '.comment-entry-show'
      answers = $('#answers');

  answers.on('click', toggleComments, function (e) {
    $(this)
        .closest('.comments')
        .find('.outer-wrap')
        .slideToggle();
    return false;
  });

  answers.on('click', toggleTextarea, function (e) {
    $(this)
        .parent()
        .next()
        .show()
        .find('textarea').focus().end()
        .end()
        .fadeOut();

    return false;
  });

  answers.on( 'keydown', commentTextarea,function (e) {
    $(this).animate({ height:'58px' });
  });
});
