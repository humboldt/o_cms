module OCms
  class Image < ActiveRecord::Base
    mount_uploader :file, ImageUploader

    default_scope { order('created_at DESC') }

    validates :name, length: { minimum: 5 }, presence: true
    validates :file, length: { minimum: 5 }, presence: true
  end
end
