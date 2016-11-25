module OCms
  class Page < ActiveRecord::Base
    default_scope { order('title ASC') }

    has_many :subpages, class_name: OCms::Page, foreign_key: 'parent_id'

    belongs_to_opts = { class_name: OCms::Page, foreign_key: 'parent_id' }
    belongs_to_opts[:optional] = true if ActiveRecord::VERSION::MAJOR >= 5
    belongs_to :parent, belongs_to_opts

    validates :title, length: { minimum: 8 }, presence: true
    validates :body, length: { minimum: 15 }, presence: true

    before_validation :create_slug
    before_validation :create_meta_title
    before_validation :create_meta_description

    DRAFT_STATUS = "draft"
    PUBLISHED_STATUS = "published"
    SCHEDULED_STATUS = "scheduled"

    STATUSES = [['Draft', DRAFT_STATUS],
               ['Publish', PUBLISHED_STATUS],
               ['Schedule', SCHEDULED_STATUS]]

    scope :published, -> { where('published_at <= ?', Time.now) }
    scope :page_parents, -> { where(parent_id: nil) }
    scope :all_except, ->(page) { where.not(id: page) }

    def create_slug
      self.slug = "#{title.parameterize}" if self.slug.blank? && self.title.present?
    end

    def create_meta_title
      self.meta_title = "#{title}" if self.meta_title.blank? && self.title.present?
    end

    def create_meta_description
      sanitized_body = ActionView::Base.full_sanitizer.sanitize(self.body)
      self.meta_description = "#{sanitized_body.first(156) + ' ...'}" if self.meta_description.blank? && self.body.present?
    end

    def draft?
      self.published_at.nil?
    end

    def published?
      self.published_at.nil? ? false : self.published_at <= Time.current
    end

    def scheduled?
      self.published_at.nil? ? false : self.published_at > Time.current
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

    def assign_attributes(new_attributes)
      if new_attributes[:status]
        status = new_attributes[:status]
        published_at = new_attributes[:published_at]

        if DRAFT_STATUS == status
          published_at = nil
        elsif PUBLISHED_STATUS == status && published_at.blank?
          published_at = Time.current
        end

        new_attributes.delete(:status)
        new_attributes[:published_at] = published_at
       end

      super
    end

    def remove_subpage_relationships
      self.subpages.clear
    end
  end
end
