$(document).on("ready page:load", function () {
  $("textarea.CommentArea").val("コメントを入力").css("color", "#ababab");
  $("textarea.CommentArea").focus(function(){
    if(this.value == "コメントを入力"){
      $(this).val("").css("color", "black");

      $(this).removeClass("CommentArea");
      $(this).addClass("AfterCommentArea");
      $(this).parents('#new_comment').next().find(".article-comment-submit").fadeIn('fast');
      $(this).parent().prev().fadeIn('fast');
    }
  });
  $("textarea.CommentArea").blur(function(){
    if(this.value == "") {
      $(this).val("コメントを入力").css("color", "#ababab");
    }
  });
});
