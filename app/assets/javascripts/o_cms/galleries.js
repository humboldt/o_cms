// Create gallery html and insert into the content area

$(document)
  .off('click.ocms-insert-gallery') // remove any previous handler
  .on('click.ocms-insert-gallery', '#gallery_insert',
    function(event){

      var element = document.querySelector("trix-editor")
      var editor = element.editor;

      embed = $('#gallery_markup').html();
      attachment = new Trix.Attachment({content: embed})
      element.editor.insertAttachment(attachment)

      $('#libraryModal').modal('hide');
  });
