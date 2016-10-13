module OCms
  class Category < ActiveRecord::Base
    default_scope { order('created_at DESC') }

    validates :name, length: { minimum: 5 }, presence: true
    validates :body, presence: true

    before_validation :create_slug
    before_validation :create_meta_title
    before_validation :create_meta_description

    def create_slug
      self.slug = "#{name.parameterize}" if self.slug.blank? && self.name.present?
    end

    def create_meta_title
      self.meta_title = "#{name}" if self.meta_title.blank? && self.name.present?
    end

    def create_meta_description
      self.meta_description = "#{body.first(156) + ' ...'}" if self.meta_description.blank? && self.body.present?
    end
  end
end
