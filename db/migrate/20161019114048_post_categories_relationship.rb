class PostCategoriesRelationship < ActiveRecord::Migration
    create_table :o_cms_post_categories, id: false do |t|
      t.belongs_to :post, index: true
      t.belongs_to :category, index: true
    end
  end
