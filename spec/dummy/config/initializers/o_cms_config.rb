# Image Sizes
OCms::Engine.config.image_sizes = {
  thumb: { resize: "resize_to_fill", width: 50, height: 50 },
  medium: { resize: "resize_to_fit", width: 200, height: 200 },
  large: { resize: "resize_to_fit", width: 300, height: 300 },
  featured_image: { resize: "resize_to_fit", width: 400, height: 400 },
  special_image: { resize: "resize_to_fill", width: 600, height: 600 }
}
