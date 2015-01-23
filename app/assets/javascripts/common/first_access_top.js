$(document).on("ready page:load", function () {
  setTimeout(function (){
    $('#first_access').animate({
      opacity: 0.3
    }, {
      duration: 1500,
      opacity: 1
    }).animate({
      duration: 500,
      opacity: 1
    }, function (){
      $('#first_access_new_button').fadeIn(2000);
    });
  }, 500);
});
