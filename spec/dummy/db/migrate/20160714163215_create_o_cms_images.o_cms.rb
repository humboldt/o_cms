# This migration comes from o_cms (originally 20160714154520)
class CreateOCmsImages < ActiveRecord::Migration
  def change
    create_table :o_cms_images do |t|
      t.string :title
      t.string :description
      t.string :file

      t.timestamps
    end
  end
end
