require 'rails_helper'

module OCms
  RSpec.describe Image, type: :model do
    let(:image) { create(:image) }

    it { is_expected.to have_many(:galleries) }
    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_presence_of(:file)}
    it { is_expected.to validate_length_of(:name).is_at_least(5) }

    describe "attributes" do
      it "has a name, file, and description attribute" do
        expect(image).to have_attributes(name: image.name, file: image.file, description: image.description)
      end
    end
  end
end
