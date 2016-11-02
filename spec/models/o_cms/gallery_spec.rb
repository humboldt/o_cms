require 'rails_helper'

module OCms
  RSpec.describe Gallery, type: :model do
    let(:gallery) { create(:gallery) }

    it { is_expected.to have_many(:images) }
    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_length_of(:name).is_at_least(5) }

    describe "attributes" do
      it "has a name and description attribute" do
        expect(gallery).to have_attributes(name: gallery.name, description: gallery.description)
      end
    end
  end
end
