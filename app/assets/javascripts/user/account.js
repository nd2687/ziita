$(document).on("ready page:load", function () {
  $('input[id=lefile]').change(function() {
    $('#photoCover').val($(this).val());
  });
});
