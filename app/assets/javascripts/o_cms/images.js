// Create image html and insert into the content area

$(document)
  .off('click.ocms-insert') // remove any previous handler
  .on('click.ocms-insert', '#insert',
    function(event){

      // Alternate text
      var alt_text = $('#alt_text').val()

      // Alignment
      var alignmentSelected = $('#alignment option:selected').val();

      if(alignmentSelected == "center")
          var alignment = (' style="margin: 0 auto; display: block;"');
      else if ($('#alignment option:selected').val() == "left")
          var alignment = (' style="margin: 0px 10px 10px 0px; float: left;"');
      else if ($('#alignment option:selected').val() == "right")
          var alignment = (' style="float: right; margin: 0px 0px 10px 10px;"');
      else
          var alignment = ('');

      // Image
      var image = $('#size option:selected').val();

      // Link To
      var linkToSelected = $('#link_to option:selected').val();

      if (linkToSelected == "none")
        var the_link = ''
      else if (linkToSelected == "url")
        var the_link = $('#link_url').val()
      else {
        var the_link = $('#link_to option:selected').val();
      }

      // Insert
      var element = document.querySelector("trix-editor")
      var editor = element.editor;
      var align_size = ('<img'+ alignment +' src="'+ image +'" alt="'+ alt_text +'" />');
      var link_to = ('<a href="'+ the_link +'">');
      var link_close = ('</a>');

      if (linkToSelected == "none")
        embed = (align_size);
      else {
        embed = (link_to + align_size + link_close);
      }
      attachment = new Trix.Attachment({content: embed})
      element.editor.insertAttachment(attachment)

      $('#libraryModal').modal('hide');
  });
