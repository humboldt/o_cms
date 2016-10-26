module OCms
  class ImageUploader < CarrierWave::Uploader::Base

    # Include RMagick or MiniMagick support:
    # include CarrierWave::RMagick
    include CarrierWave::MiniMagick

    # Choose what kind of storage to use for this uploader:
    storage :file
    # storage :fog

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    # Provide a default URL as a default if there hasn't been a file uploaded:
    # def default_url
    #   # For Rails 3.1+ asset pipeline compatibility:
    #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    #
    #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    # end

    # Process files as they are uploaded:
    # process scale: [200, 300]
    #
    # def scale(width, height)
    #   # do something
    # end

    # Admin thumb size used in the library index
    version :admin_thumb do
      process :resize_to_fill => [125, 125]
    end

    # Create different versions of the uploaded files using the images sizes config
    OCms::Engine.config.image_sizes.each_pair do |image_type, dimensions|
      version image_type do
        process dimensions[:resize].to_sym => [dimensions[:width], dimensions[:height]]
      end
    end

    # Extensions which are allowed to be uploaded.
    def extension_whitelist
      %w(jpg jpeg gif png)
    end

    # Override the filename of the uploaded files:
    # Avoid using model.id or version_name here, see uploader/store.rb for details.
    # def filename
    #   "something.jpg" if original_filename
    # end

  end
end
