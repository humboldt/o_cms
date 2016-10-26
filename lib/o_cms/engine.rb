module OCms
  class Engine < ::Rails::Engine
    isolate_namespace OCms

    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.helper false
    end

    config.image_sizes = {
      thumb: { resize: "resize_to_fill", width: 50, height: 50 },
      medium: { resize: "resize_to_fit", width: 200, height: 200 },
      large: { resize: "resize_to_fit", width: 300, height: 350 },
      featured: { resize: "resize_to_fit", width: 400, height: 400 },
      special: { resize: "resize_to_fill", width: 600, height: 600 }
    }
  end
end
