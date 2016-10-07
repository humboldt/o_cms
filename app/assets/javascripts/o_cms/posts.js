// Show the scheduled for option (published_at field & label)

document.addEventListener("turbolinks:load", function() {
  // console.log ( 'Document ready loaded' );
  $('.status-options').change(function(event) {
    // console.log ( 'Status change event active' );
    if ($('.status-options').val() == 'draft'){
      // console.log ( 'Remove show class' );
      $('.publish_at_fields').removeClass('show');
    }
    if ($('.status-options').val() == 'scheduled'){
      // console.log ( 'Add show class' );
      $('.publish_at_fields').addClass('show');
    }
    if ($('.status-options').val() == 'published'){
      // console.log ( 'Remove show class' );
      $('.publish_at_fields').removeClass('show');
    }
  });
})
