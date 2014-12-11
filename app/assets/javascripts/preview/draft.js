$(function(){
  if($('#article-new').length){
    var typingTimer;
    var doneTypingInterval = 2000;

    $('form').submit(function(){
      if($('textarea#article_body').val() === "" && 
         $('input#article_title').val() === "" && 
           $('input#article_tag_list').val() === "" || $('input#article_title').val() === ""){
        alert('入力値が不正です。');
        return false;
      };
    });

    $('form').keyup(function(){
      clearTimeout(typingTimer);
      typingTimer = setTimeout(doneTyping, doneTypingInterval);
    });

    $('form').keydown(function(){
      clearTimeout(typingTimer);
    });

    function doneTyping(){
      var identify_name = $('.create-temp').attr('data-identify_name');
      var article_access_token = $('.create-temp').attr('data-access_token');
      var article_valid = $('.create-temp').attr('data-article_valid');
      var params = {};
      if($('input#article_title').val() === ""){
        params['title'] = "No title";
        $('input#article_title').val(params['title']);
      }else{
        params['title'] = $('input#article_title').val();
      };
      params['body'] = $('textarea#article_body').val();
      params['tag_list'] = $('input#article_tag_list').val();
      params['access_token'] = article_access_token;
      params['article_valid'] = article_valid;

      $.ajax({
        url: '/' + identify_name + '/articles/' + article_access_token + '/create_temp',
        type: 'post',
        data: params,
        success: function(data){
          if(data[0] !== false){
            if($('.create-temp').attr("data-article_valid") !== "true"){
              $('.create-temp').attr("data-article_valid", "true");
            };
            var $nav = $('.footerNav');
            $nav.slideDown(200, function(){ $nav.delay(1000).slideUp(500);});
          }
          else if(data[0] === false){
            data.shift();
            var errors = data;
            var error = "";
            $.each(errors, function(i, value){
              error += value += "\n"
            });
            alert(error);
          }
        },
        error: function(){
          alert('error!');
        }
      });
    };
  };
})
