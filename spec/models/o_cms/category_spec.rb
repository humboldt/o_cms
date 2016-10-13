require 'rails_helper'

module OCms
  RSpec.describe Category, type: :model do
    let(:category) { create(:category) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:name).is_at_least(5) }

    describe "attributes" do
      it "has a name, slug, icon, body, meta_title, meta_description and meta_keywords attribute" do
        expect(category).to have_attributes(name: category.name, slug: category.slug, icon: category.icon, body: category.body, meta_title: category.meta_title, meta_description: category.meta_description, meta_keywords: category.meta_keywords)
      end
    end

    describe "#create_slug" do
      it "creates the category slug from the category name" do
        category = Category.create(name: RandomData.random_sentence, icon: RandomData.random_slug, body: RandomData.random_paragraph)
        expect(category.slug).to eq (category.name.parameterize)
      end

      it "does not amend the category slug if one is already entered" do
        category = Category.create(name: RandomData.random_sentence, slug: RandomData.random_slug, icon: RandomData.random_slug, body: RandomData.random_paragraph)
        expect(category.slug).to eq (category.slug)
      end
    end

    describe "#create_meta_title" do
      it "creates the category meta title from the category name" do
        category = Category.create(name: RandomData.random_sentence, slug: RandomData.random_slug, icon: RandomData.random_slug, body: RandomData.random_paragraph)
        expect(category.meta_title).to eq (category.name)
      end

      it "does not amend the category meta title if one is already entered" do
        category = Category.create(name: RandomData.random_sentence, slug: RandomData.random_slug, icon: RandomData.random_slug, body: RandomData.random_paragraph, meta_title: RandomData.random_sentence)
        expect(category.meta_title).to eq (category.meta_title)
      end
    end

    describe "#create_meta_description" do
      it "creates the category meta description from the category body content" do
        category = Category.create(name: RandomData.random_sentence, slug: RandomData.random_slug, icon: RandomData.random_slug, body: RandomData.random_paragraph)
        expect(category.meta_description).to eq (category.body.first(156) + ' ...')
      end

      it "does not amend the category meta description if one is already entered" do
        category = Category.create(name: RandomData.random_sentence, slug: RandomData.random_slug, icon: RandomData.random_slug, body: RandomData.random_paragraph, meta_description: RandomData.random_paragraph)
        expect(category.meta_description).to eq (category.meta_description)
      end
    end
  end
end
