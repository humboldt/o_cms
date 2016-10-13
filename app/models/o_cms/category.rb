module OCms
  class Category < ActiveRecord::Base

    validates :name, length: { minimum: 8 }, presence: true
    validates :body, presence: true
  end
end
