// Create image html and insert into the content area

$(document)
  .off('click.ocms-featured-image') // remove any previous handler
  .on('click.ocms-featured-image', '#featured_image',
    function(event){
      var source = ($(this).attr("src"));
      var alt = ($(this).attr("alt"));
      var featured_source = (source.replace('admin_thumb', 'featured'));

      $('input.featured-image').attr("value", featured_source);
      $('#featured_preview').remove();
      $('.featured-card .col-sm-12').prepend('<img id="featured_preview" src="' + featured_source + '" alt="' + alt + '">')

      $('#featuredModal').modal('hide');
  });
