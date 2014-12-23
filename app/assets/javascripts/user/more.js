$(function(){

  //$('ul.articles').children(".x-more").attr("class", "x-more");

  function min_article_id () {
    var min = 0;
    $('ul.articles').children('li').each(function(){
      var li = $(this);
      var id = Number(li.data("article_id"));
      if(id && (min == 0 || id < min)) min = id;
    });
    return min;
  }

  var loading_more = false;
  $(window).scroll(function(){
    if(loading_more) return;
    var more = $('ul.articles').children(".x-more");
    var height = $("ul.articles").height();
    var scroll_height = $(window).scrollTop() + $(window).height();
    if(more.length == 0) return;

    if(scroll_height > height + 155){
      var data = { older_than: min_article_id() };
      loading_more = true;

      $.ajax({
        url: more.data("href"),
        type: "GET",
        cache: false,
        data: data,
        data_type: "json",
        success : function(result, status, xhr) {
          more.remove();
          var lis = $(result.html).find("li").filter(".list-group-item");
          if(lis.length > 0){
            $("ul.articles").append(lis);
            lis.show();
            $("ul.articles").children(".x-more").attr("class", "x-more");
          };
        },
        error : function(result, status, xhr){
        },
        complete : function() {
          loading_more = false;
        }
      });
    };
  });
})
