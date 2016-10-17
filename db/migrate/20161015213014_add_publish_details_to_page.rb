class AddPublishDetailsToPage < ActiveRecord::Migration
  def change
    add_column :o_cms_pages, :published_at, :datetime
  end
end
