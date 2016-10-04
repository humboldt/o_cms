// Show the scheduled for option (published_at field & label)

$( document ).ready(function() {
  $('.status-options').change(function(event) {
    if ($('.status-options').val() == 'draft'){
      $('.publish_at_fields').removeClass('show');
    }
    if ($('.status-options').val() == 'scheduled'){
      $('.publish_at_fields').addClass('show');
    }
    if ($('.status-options').val() == 'published'){
      $('.publish_at_fields').removeClass('show');
    }
  });
});
