class CreateOCmsImages < ActiveRecord::Migration
  def change
    create_table :o_cms_images do |t|
      t.string :name
      t.string :file
      t.text :description

      t.timestamps null: false
    end
  end
end
