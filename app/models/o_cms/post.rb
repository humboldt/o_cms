module OCms
  class Post < ActiveRecord::Base
    default_scope { order('created_at DESC') }

    validates :title, length: { minimum: 8 }, presence: true
    validates :body, length: { minimum: 15 }, presence: true

    before_validation :create_slug
    before_validation :create_meta_title
    before_validation :create_meta_description
    before_save :assign_published_at
    after_save :scheduled_to_published

    DRAFT_STATUS = "draft"
    PUBLISHED_STATUS = "published"
    SCHEDULED_STATUS = "scheduled"

    STATUSES = [['Draft', DRAFT_STATUS],
               ['Publish', PUBLISHED_STATUS],
               ['Schedule', SCHEDULED_STATUS]]

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
      if self.status == DRAFT_STATUS
        self.published_at = nil
      elsif self.status == PUBLISHED_STATUS
        self.published_at = Time.now
      end
    end

    def scheduled_to_published
      if self.status == SCHEDULED_STATUS && self.published_at < Time.now
        self.status == PUBLISHED_STATUS
      end
    end

    def draft?
      self.status == DRAFT_STATUS
    end

    def published?
      self.status == PUBLISHED_STATUS
    end

    def scheduled?
      self.status == SCHEDULED_STATUS
    end
  end
end
