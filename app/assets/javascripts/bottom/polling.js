SHAREHUB.namespace('polling');

(function (polling, $) {
  polling.updateAnswers = function () {
    var questionId = $("#question-body").data('id');
    $.getScript("/answers.js?question_id=" + questionId + "&after=" + latestAnswerTime);
  };

  polling.updateComments = function () {
    var answerIds = [];
    $(".answer").each(function () {
      answerIds.push($(this).data('id'));
    });
    $.getScript("/comments.js?answer_ids=" + answerIds + "&after=" + latestCommentTime);
  };

  if ($("#post-page #answers").length > 0) {
    setTimeout(SHAREHUB.polling.updateComments, 8000);
    setTimeout(SHAREHUB.polling.updateAnswers, 5000);
  }
})(SHAREHUB.polling, jQuery, undefined);
