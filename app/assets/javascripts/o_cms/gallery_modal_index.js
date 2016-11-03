// Remove the galleries modal show view when the galleries tab is clicked

$(document)
  .off('click.ocms-gallery-modal-back') // remove any previous handler
  .on('click.ocms-gallery-modal-back', '.gallery-nav-link',
    function(event){
      $('.gallery-picker').removeClass('hide')
      $('.gallery-options').remove();
});
