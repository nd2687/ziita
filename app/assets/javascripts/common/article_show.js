$(document).on("ready page:load", function () {

  var form = $(document).find('form#new_comment');

  form.bind("ajax:success", function(e, data, status, xhr){
    if($('#new_comment').find('.ErrorCommentName').length > 0){$('#new_comment').find('.ErrorCommentName').remove();}
    if($('#new_comment').find('.ErrorCommentBody').length > 0){$('#new_comment').find('.ErrorCommentBody').remove();}

    if(data.success !== "undefined"){
      if($('input#comment_name').val().length > 30){
        $('#new_comment').prepend("<p class='ErrorCommentName' style='color:red;'>名前は30文字以内で入力してください。</p>");}
      var body = $('textarea#comment_body').val().replace(/^\s+|\s+$/g, "");
      if(body === ''){ $('#comment_name').next().prepend("<p class='ErrorCommentBody' style='color:red;'>本文を入力してください。</p>");}
    }

    var json = jQuery.parseJSON(data[0]),
      comment_body = "",
      txt = json.body,
      date = data[1];
    // 改行を反映させる
    txt = txt.replace(/\r\n/g, '\n');
    txt = txt.replace(/\r/g, '\n');
    txt = txt.split('\n');
    $.each(txt, function(i, value){
      if(0<=i && i+1 != txt.length){
        comment_body += value + "<br>"
      }else{
        if(i+1 == txt.length){ comment_body += value }
      }
    });
    var list_group_item_block = $('<li class="list-group-item" style="display:none;"></li>');
    list_group_item_block = list_group_item_block.append('<p>'+json.name+'</p>');
    list_group_item_block = list_group_item_block.append(comment_body);
    list_group_item_block = list_group_item_block.append('<p class="right-elm">'+date+'</p>');
    $('ul.list-group').append(list_group_item_block);
    $('li.list-group-item').slideDown('slow');
    $('#comment_name').val('');
    $('#comment_body').val('');
  });

  form.bind("ajax:error", function(e, data, status, xhr) {
    console.log("error");
  })

  $('#CommentSubmit').on('click', function(){
    var target = $('.list-group li:last-child').get(0).offsetTop;
    $('html,body').animate({ scrollTop: target }, 'fast');
  })
})
