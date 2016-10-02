module OCms
  class Post < ActiveRecord::Base
    validates :title, length: { minimum: 8 }, presence: true
    validates :body, length: { minimum: 15 }, presence: true
  end
end
