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

    describe "#create_slug" do
      it "creates the page slug from the page title" do
        page = Page.create(title: RandomData.random_sentence, body: RandomData.random_sentence)
        expect(page.slug).to eq (page.title.parameterize)
      end

      it "does not amend the page slug if one is already entered" do
        page = Page.create(title: RandomData.random_sentence, slug: RandomData.random_slug, body: RandomData.random_sentence)
        expect(page.slug).to eq (page.slug)
      end
    end

    describe "#create_meta_title" do
      it "creates the page meta title from the page title" do
        page = Page.create(title: RandomData.random_sentence, body: RandomData.random_sentence)
        expect(page.meta_title).to eq (page.title)
      end

      it "does not amend the page meta title if one is already entered" do
        page = Page.create(title: RandomData.random_sentence, body: RandomData.random_sentence, meta_title: RandomData.random_sentence)
        expect(page.meta_title).to eq (page.meta_title)
      end
    end

    describe "#create_meta_description" do
      it "creates the page meta description from the page body content" do
        page = Page.create(title: RandomData.random_sentence, body: RandomData.random_paragraph)
        expect(page.meta_description).to eq (page.body.first(156) + ' ...')
      end

      it "does not amend the page meta description if one is already entered" do
        page = Page.create(title: RandomData.random_sentence, body: RandomData.random_sentence, meta_description: RandomData.random_paragraph)
        expect(page.meta_description).to eq (page.meta_description)
      end
    end

    describe "#draft?" do
      it "returns true if the page published at value is nil" do
        page = Page.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: nil)
        expect(page.draft?).to be_truthy
      end
      it "returns false if page published at value is present" do
        page = Page.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: Time.now - 2.days)
        expect(page.draft?).to be_falsey
      end
    end

    describe "#published?" do
      it "returns true if the page published at time date is in the past" do
        page = Page.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: Time.now - 2.days)
        expect(page.published?).to be_truthy
      end
      it "returns false if published at is not present" do
        page = Page.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: nil)
        expect(page.published?).to be_falsey
      end
      it "returns false if published at is in the future" do
        page = Page.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: Time.now + 2.days)
        expect(page.published?).to be_falsey
      end
    end

    describe "#scheduled?" do
      it "returns true if the page published at time date is in the future" do
        page = Page.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: Time.now + 2.days)
        expect(page.scheduled?).to be_truthy
      end
      it "returns false if the page published at time date is in the past" do
        page = Page.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: Time.now - 2.days)
        expect(page.scheduled?).to be_falsey
      end
      it "returns false if page status is not present" do
        page = Page.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: nil)
        expect(page.scheduled?).to be_falsey
      end
    end
  end
end
