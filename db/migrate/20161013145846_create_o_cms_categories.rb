class CreateOCmsCategories < ActiveRecord::Migration
  def change
    create_table :o_cms_categories do |t|
      t.string :name
      t.string :slug
      t.string :icon
      t.text :body
      t.string :meta_title
      t.string :meta_description
      t.string :meta_keywords

      t.timestamps null: false
    end
  end
end
