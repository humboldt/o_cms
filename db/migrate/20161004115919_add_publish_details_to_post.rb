class AddPublishDetailsToPost < ActiveRecord::Migration
  def change
    add_column :o_cms_posts, :status, :string, default: 'Draft'
    add_column :o_cms_posts, :published_at, :datetime
  end
end
