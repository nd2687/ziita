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

    preview.scroll(function(){
      input.scrollTop(preview.scrollTop());
    });
  };
});
