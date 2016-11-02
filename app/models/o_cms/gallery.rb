module OCms
  class Gallery < ActiveRecord::Base
    default_scope { order('created_at DESC') }
    
    has_many :image_gallery
    has_many :images, :through => :image_gallery

    validates :name, length: { minimum: 5 }, presence: true
  end
end
