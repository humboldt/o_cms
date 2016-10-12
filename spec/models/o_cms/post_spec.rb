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

    describe "#create_slug" do
      it "creates the post slug from the post title" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence)
        expect(post.slug).to eq (post.title.parameterize)
      end

      it "does not amend the post slug if one is already entered" do
        post = Post.create(title: RandomData.random_sentence, slug: RandomData.random_slug, body: RandomData.random_sentence)
        expect(post.slug).to eq (post.slug)
      end
    end

    describe "#create_meta_title" do
      it "creates the post meta title from the post title" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence)
        expect(post.meta_title).to eq (post.title)
      end

      it "does not amend the post meta title if one is already entered" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, meta_title: RandomData.random_sentence)
        expect(post.meta_title).to eq (post.meta_title)
      end
    end

    describe "#create_meta_description" do
      it "creates the post meta description from the post body content" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_paragraph)
        expect(post.meta_description).to eq (post.body.first(156) + ' ...')
      end

      it "does not amend the post meta description if one is already entered" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, meta_description: RandomData.random_paragraph)
        expect(post.meta_description).to eq (post.meta_description)
      end
    end

    describe "#draft?" do
      it "returns true if the post published at value is nil" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: nil)
        expect(post.draft?).to be_truthy
      end
      it "returns false if post published at value is present" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: Time.now - 2.days)
        expect(post.draft?).to be_falsey
      end
    end

    describe "#published?" do
      it "returns true if the post published at time date is in the past" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: Time.now - 2.days)
        expect(post.published?).to be_truthy
      end
      it "returns false if published at is not present" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: nil)
        expect(post.published?).to be_falsey
      end
      it "returns false if published at is in the future" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: Time.now + 2.days)
        expect(post.published?).to be_falsey
      end
    end

    describe "#scheduled?" do
      it "returns true if the post published at time date is in the future" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: Time.now + 2.days)
        expect(post.scheduled?).to be_truthy
      end
      it "returns false if the post published at time date is in the past" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: Time.now - 2.days)
        expect(post.scheduled?).to be_falsey
      end
      it "returns false if post status is not present" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: nil)
        expect(post.scheduled?).to be_falsey
      end
    end
  end
end
