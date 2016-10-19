require 'rails_helper'

module OCms
  RSpec.describe PostCategory, type: :model do
    it { is_expected.to belong_to(:post) }
    it { is_expected.to belong_to(:category) }
  end
end
