// Show the URL field if the link to URL option is selected in the library modal show view

$(document)
  .off('change.ocms-images-link') // remove any previous handler
  .on('change.ocms-images-link', '#link_to',
    function(event){
      if ($('.link-to-select').val() == 'url'){
        $('.link_url').removeClass('hide');
      } else {
        $('.link_url').addClass('hide');
      }
});
