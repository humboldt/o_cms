module OCms
  class Page < ActiveRecord::Base
    validates :title, length: { minimum: 8 }, presence: true
    validates :body, length: { minimum: 15 }, presence: true

    before_validation :create_slug
    before_validation :create_meta_title
    before_validation :create_meta_description

    def create_slug
      self.slug = "#{title.parameterize}" if self.slug.blank? && self.title.present?
    end

    def create_meta_title
      self.meta_title = "#{title}" if self.meta_title.blank? && self.title.present?
    end

    def create_meta_description
      self.meta_description = "#{body.first(156) + ' ...'}" if self.meta_description.blank? && self.body.present?
    end
  end
end
