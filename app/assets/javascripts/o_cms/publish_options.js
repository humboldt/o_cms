// Show the published_at field when the scheduled option is selected

$(document)
  .off('change.ocms-status-options') // remove any previous handler
  .on('change.ocms-status-options', '.status-options',
    function(event){
      if ($('.status-options').val() == 'scheduled'){
        $('.publish_at_fields').addClass('show');
      } else {
        $('.publish_at_fields').removeClass('show');
      }
});
