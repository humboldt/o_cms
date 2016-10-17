# initilizer - user can override defaults and add thier own

  OCms::Engine.config.image_sizes = {
    foo: { width: 324, height: 200 },
    thumb: { width: 100, height: 200 },
    featured_image: { width: 100, height: 200 }
  }
