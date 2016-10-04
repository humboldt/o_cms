module OCms
  class Post < ActiveRecord::Base
    default_scope { order('created_at DESC') }

    validates :title, length: { minimum: 8 }, presence: true
    validates :body, length: { minimum: 15 }, presence: true

    before_validation :create_slug
    before_validation :create_meta_title
    before_validation :create_meta_description
    before_save :assign_published_at

    STATUS = [['Draft', 'draft'],
              ['Publish', 'published'],
              ['Schedule', 'scheduled']]

    def create_slug
      self.slug = "#{title.parameterize}" if self.slug.blank? && self.title.present?
    end

    def create_meta_title
      self.meta_title = "#{title}" if self.meta_title.blank? && self.title.present?
    end

    def create_meta_description
      self.meta_description = "#{body.first(156) + ' ...'}" if self.meta_description.blank? && self.body.present?
    end

    def assign_published_at
      if self.status == "draft"
        self.published_at = 'null'
      elsif self.status == "published"
        self.published_at = Time.now
      end
    end
  end
end
