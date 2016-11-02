require 'rails_helper'

module OCms
  RSpec.describe ImageGallery, type: :model do
    it { is_expected.to belong_to(:image) }
    it { is_expected.to belong_to(:gallery) }
  end
end
