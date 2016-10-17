module OCms
  class Engine < ::Rails::Engine
    isolate_namespace OCms

    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.helper false
    end

    config.image_sizes = {
      medium: { width: 100, height: 200 },
      thumb: { width: 100, height: 200 },
      featured_image: { width: 100, height: 200 }
    }
  end
end
