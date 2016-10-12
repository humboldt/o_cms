class AdjustPostStatusDefaultValue < ActiveRecord::Migration
  def change
    change_column :o_cms_posts, :status, :string, default: 'draft'
  end
end
