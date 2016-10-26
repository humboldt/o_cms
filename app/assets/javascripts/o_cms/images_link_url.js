// Show the URL field if the link to URL option is selected
document.addEventListener("turbolinks:load", function() {
  $(document).on("click","#link_to",function(event){
    $('#link_to').change(function(event) {
      if ($('.link-to-select').val() == 'url'){
        $('.link_url').removeClass('hide');
      } else {
        $('.link_url').addClass('hide');
      }
    });
  });
});
