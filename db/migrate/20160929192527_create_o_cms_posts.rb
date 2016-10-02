class CreateOCmsPosts < ActiveRecord::Migration
  def change
    create_table :o_cms_posts do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.text :excerpt
      t.string :featured_image
      t.string :meta_title
      t.string :meta_description
      t.string :meta_keywords

      t.timestamps null: false
    end
  end
end
