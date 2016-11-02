module OCms
  class Image < ActiveRecord::Base
    mount_uploader :file, ImageUploader

    default_scope { order('created_at DESC') }

    has_many :image_gallery
    has_many :galleries, :through => :image_gallery

    validates :name, length: { minimum: 5 }, presence: true
    validates :file, length: { minimum: 5 }, presence: true
  end
end
