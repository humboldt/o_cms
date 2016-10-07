class DropStatusFromPosts < ActiveRecord::Migration
  def change
    remove_column :o_cms_posts, :status
  end
end
