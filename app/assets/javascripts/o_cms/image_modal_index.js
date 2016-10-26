// Show the modal index
document.addEventListener("turbolinks:load", function() {
  $(document).on("click",".image-nav-link",function(event){
    $('.image-picker').removeClass('hide')
    $('.image-options').remove();
  });
})
