require 'rails_helper'

module OCms
  RSpec.describe Post, type: :model do
    let(:post) { create(:post) }

    it { is_expected.to validate_presence_of(:title)}
    it { is_expected.to validate_presence_of(:body)}
    it { is_expected.to validate_length_of(:title).is_at_least(8) }
    it { is_expected.to validate_length_of(:body).is_at_least(15) }

    describe "attributes" do
      it "has a title, slug, body, excerpt, featured_image, meta_title, meta_description and meta_keywords attribute" do
        expect(post).to have_attributes(title: post.title, slug: post.slug, body: post.body, excerpt: post.excerpt, featured_image: post.featured_image, meta_title: post.meta_title, meta_description: post.meta_description, meta_keywords: post.meta_keywords)
      end
    end
  end
end
