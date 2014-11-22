$(document).on("ready page:load", function () {
  $(window).scroll(function(){
    var now = $(window).scrollTop();
    if(now > 1500){
      $('.page-top').fadeIn('slow');
    }else{
      $('.page-top').fadeOut('slow');
    }
  });

  $('.move-page-top').on('click', function(){
    $('html,body').animate({scrollTop:0}, 'slow');
  });
});
