class ImagesGalleriesRelationship < ActiveRecord::Migration
  create_table :o_cms_image_galleries, id: false do |t|
    t.belongs_to :image, index: true
    t.belongs_to :gallery, index: true
  end
end
