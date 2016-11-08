class AddParentFieldsToPage < ActiveRecord::Migration
  def change
    add_column :o_cms_pages, :parent_id, :integer
    add_column :o_cms_pages, :order, :integer
  end
end
