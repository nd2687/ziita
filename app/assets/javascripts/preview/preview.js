$(function() {
  if($('#preview-page').length){
    marked.setOptions({
        langPrefix: ''
    });

    $('#article_body').keyup(function() {
      var src = $(this).val();
      var html = marked(src);

      $('#result').html(html);

      $('pre code').each(function(i, block) {
          hljs.highlightBlock(block);
      });
    });

    var preview = $('#result');
    var input = $('#article_body');

    input.scroll(function(){
      var change_height_pre = preview.get(0).scrollHeight;
      var change_height = input.get(0).scrollHeight;
      var input_percentage = input.scrollTop() / change_height;
      var pre_top = change_height_pre * input_percentage;
      preview.scrollTop(pre_top);
    });
  };
});
