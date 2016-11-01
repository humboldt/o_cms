class CreateOCmsGalleries < ActiveRecord::Migration
  def change
    create_table :o_cms_galleries do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
