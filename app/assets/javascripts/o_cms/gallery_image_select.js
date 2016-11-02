/*

  Gallery image selector

*/

// On load add selected class to checked images
$(document)
  .on('turbolinks:load',
    function() {
      $('.gallery-options span input:checkbox:checked').parent('span').addClass('selected');
  });

// Toggle the style and checked on click of image
$(document)
  .off('click.ocms-gallery-image-option') // remove any previous handler
  .on('click.ocms-gallery-image-option', 'img.gallery-image-option',
    function(event){

    	var wrapper = $('.gallery-options');
    	var parent = $(this).parent('span');
    	var image = $('img.gallery-image-option');
    	var checkbox_sibling = $(parent).find('input:checkbox');

    	if (!$(parent).hasClass('selected')) {
    	    $(parent).addClass('selected');
    		$(checkbox_sibling).prop('checked',true);
    	} else {
    	    $(parent).removeClass('selected');
    		$(checkbox_sibling).prop('checked',false);
    	}
  });
