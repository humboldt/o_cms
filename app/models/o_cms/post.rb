module OCms
  class Post < ActiveRecord::Base
    default_scope { order('created_at DESC') }

    validates :title, length: { minimum: 8 }, presence: true
    validates :body, length: { minimum: 15 }, presence: true

    before_validation :create_slug
    before_validation :create_meta_title
    before_validation :create_meta_description
    before_save :assign_published_at

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

    def draft?
      self.published_at.nil?
    end

    def published?
      self.published_at <= Time.now
    end

    def scheduled?
      self.published_at > Time.now
    end

    def status
      if self.draft?
        return DRAFT_STATUS
      elsif self.published?
        return PUBLISHED_STATUS
      elsif self.scheduled?
        return SCHEDULED_STATUS
      end
    end
  end
end
