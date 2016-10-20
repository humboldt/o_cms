// Publish Options
// Show the published_at field when the scheduled option is selected

document.addEventListener("turbolinks:load", function() {
  $('.status-options').change(function(event) {
    if ($('.status-options').val() == 'scheduled'){
      $('.publish_at_fields').addClass('show');
    } else {
      $('.publish_at_fields').removeClass('show');
    }
  });
})
