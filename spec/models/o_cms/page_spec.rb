require 'rails_helper'

module OCms
  RSpec.describe Page, type: :model do
    let(:page) { create(:page) }

    it { is_expected.to validate_presence_of(:title)}
    it { is_expected.to validate_presence_of(:body)}
    it { is_expected.to validate_length_of(:title).is_at_least(8) }
    it { is_expected.to validate_length_of(:body).is_at_least(15) }

    describe "attributes" do
      it "has a title, slug, body, excerpt, featured_image, meta_title, meta_description and meta_keywords attribute" do
        expect(page).to have_attributes(title: page.title, slug: page.slug, body: page.body, excerpt: page.excerpt, featured_image: page.featured_image, meta_title: page.meta_title, meta_description: page.meta_description, meta_keywords: page.meta_keywords)
      end
    end
  end
end
