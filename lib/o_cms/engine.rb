module OCms
  class Engine < ::Rails::Engine
    isolate_namespace OCms

    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.helper false
    end

    # OCms::Engine.image_sizes
    config.image_sizes = {
      medium: { width: 100, height: 200 },
      thumb: { width: 100, height: 200 },
      featured_image: { width: 100, height: 200 }
    }
  end
end


# OCms::Engine.config.image_sizes.each_pair { |image_type, dimensions| p image_type }
# OCms::Engine.config.image_sizes.each_pair { |image_type, dimensions| p "Type #{image_type} - #{dimensions[:width]} x #{dimensions[:height]}" }
