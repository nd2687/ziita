$(document).on("ready page:load", function () {
  $('.article-comment-submit').on("click", function(){
    var article_access_token = $("#article-ptag").attr("data-article-access_token");
    var current_user = $("#article-ptag").attr("data-current_user");
    var comment_name = $("input#comment_name").val();
    var params = {}
    if(comment_name.length > 16){ alert('名前は16文字以内にしてください。'); return false};
    if(comment_name === ""){
      if(current_user.length > 0){
        params['name'] = current_user
      }else{
        params['name'] = "名無し"
      }
    }else{
      params['name'] = comment_name;
    }

    var comment_body = $('textarea#comment_body').val();
    // 行頭行末の空白を削除
    var body = comment_body.replace(/^\s+|\s+$/g, "");
    if(body == ''){
      alert('本文を入力してください。');
      return false;
    }else{
      params['body'] = body;
    }

    $.ajax({
      url: '/articles/' + article_access_token + '/comments',
      type: 'POST',
      data: params,
      data_type: 'json',
      success: function(comments){
        $('#loading').show();
        var comment_body = "";
        var txt = comments[1];
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
        list_group_item_block = list_group_item_block.append('<p>'+comments[0]+'</p>');
        list_group_item_block = list_group_item_block.append(comment_body);
        list_group_item_block = list_group_item_block.append('<p class="right-elm">'+comments[2]+'</p>');
        $('ul.list-group').append(list_group_item_block);
        $('li.list-group-item').slideDown('slow');
        $('#comment_name').val('');
        $('#comment_body').val('');
        setTimeout(function(){
          $('#loading').hide();
        }, 600);
      },
      error: function(){
        alert('error!');
      }
    })
  });
  return false;
})
