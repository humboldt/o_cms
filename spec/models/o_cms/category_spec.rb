require 'rails_helper'

module OCms
  RSpec.describe Category, type: :model do
    let(:category) { create(:category) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:name).is_at_least(8) }

    describe "attributes" do
      it "has a name, slug, icon, body, meta_title, meta_description and meta_keywords attribute" do
        expect(category).to have_attributes(name: category.name, slug: category.slug, icon: category.icon, body: category.body, meta_title: category.meta_title, meta_description: category.meta_description, meta_keywords: category.meta_keywords)
      end
    end
  end
end
