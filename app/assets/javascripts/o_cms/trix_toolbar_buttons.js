// Trix toolbar

// Block in paragraphs
(function() {
  Trix.config.blockAttributes.default.tagName = "p"
}).call(this);

// Library button
(function() {
  var buttonHTML = '<button type="button" class="library" data-trix-attribute="library" data-toggle="modal" data-target="#libraryModal" title="library"><i class="fa fa-image"></i></button>'
  var groupElement = Trix.config.toolbar.content.querySelector(".text_tools")
  groupElement.insertAdjacentHTML("beforeend", buttonHTML)
}).call(this);
