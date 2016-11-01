module OCms
  class Gallery < ActiveRecord::Base
    validates :name, length: { minimum: 5 }, presence: true
  end
end
