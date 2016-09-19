require 'rails_helper'

module OCms
  RSpec.describe Image, type: :model do
    let(:image) { create(:image) }

    describe "attributes" do
      it "has a name, file, and description attribute" do
        expect(image).to have_attributes(name: image.name, file: image.file, description: image.description)
      end
    end
  end
end
