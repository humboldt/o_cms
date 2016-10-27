// Remove the library modal show view when the images tab is clicked

$(document)
  .off('click.ocms-modal-back') // remove any previous handler
  .on('click.ocms-modal-back', '.image-nav-link',
    function(event){
      $('.image-picker').removeClass('hide')
      $('.image-options').remove();
});
