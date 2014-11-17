$(function() {
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
});

