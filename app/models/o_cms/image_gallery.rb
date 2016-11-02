module OCms
  class ImageGallery < ActiveRecord::Base
    belongs_to :image
    belongs_to :gallery
  end
end
