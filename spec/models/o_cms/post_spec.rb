require 'rails_helper'

module OCms
  RSpec.describe Post, type: :model do
    let(:post) { create(:post) }

    it { is_expected.to have_many(:categories) }

    it { is_expected.to validate_presence_of(:title)}
    it { is_expected.to validate_presence_of(:body)}
    it { is_expected.to validate_length_of(:title).is_at_least(8) }
    it { is_expected.to validate_length_of(:body).is_at_least(15) }

    describe "attributes" do
      it "has a title, slug, body, excerpt, featured_image, meta_title, meta_description and meta_keywords attribute" do
        expect(post).to have_attributes(title: post.title, slug: post.slug, body: post.body, excerpt: post.excerpt, featured_image: post.featured_image, meta_title: post.meta_title, meta_description: post.meta_description, meta_keywords: post.meta_keywords)
      end
    end

    describe "scopes" do
      describe "published," do
        before do
          @published_post = Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, published_at: 2.days.ago)
          post = create(:post)
        end

        it "returns the published post only" do
          expect(Post.published.count).to eq(1)
          expect(Post.published).to include(@published_post)
        end

        it "does not return the post" do
          expect(Post.published.count).to_not eq(2)
          expect(Post.published).to_not include(post)
        end
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
        post = Post.create(title: RandomData.random_sentence, body: "<div><figure class=\"attachment attachment-content\" data-trix-attachment=\"{&quot;content&quot;:&quot;<img style=\\&quot;margin: 0 auto; display: block;\\&quot; src=\\&quot;/uploads/o_cms/image/file/35/medium_czibgxph6asx.jpg\\&quot; alt=\\&quot;New Resize\\&quot; />&quot;}\" data-trix-content-type=\"undefined\"><img style=\"margin: 0 auto; display: block;\" src=\"/uploads/o_cms/image/file/35/medium_czibgxph6asx.jpg\" alt=\"New Resize\"><figcaption class=\"caption\"></figcaption></figure><br><br>You have spent months dreaming and planning your bike journey. You've poured over maps and shopped for gear. <br><figure class=\"attachment attachment-content\" data-trix-attachment=\"{&quot;content&quot;:&quot;<a href=\\&quot;/uploads/o_cms/image/file/36/medium_74l818xu6asx.jpg\\&quot;><img style=\\&quot;float: right; margin: 0px 0px 10px 10px;\\&quot; src=\\&quot;/uploads/o_cms/image/file/36/medium_74l818xu6asx.jpg\\&quot; alt=\\&quot;Brbrbrbryay\\&quot; /></a>&quot;}\" data-trix-content-type=\"undefined\"><a href=\"/uploads/o_cms/image/file/36/medium_74l818xu6asx.jpg\"><img style=\"float: right; margin: 0px 0px 10px 10px;\" src=\"/uploads/o_cms/image/file/36/medium_74l818xu6asx.jpg\" alt=\"Brbrbrbryay\"></a><figcaption class=\"caption\"></figcaption></figure>You've trained well hopefully you have. There is a frantic joy/dread to those final hours before you set out on a journey.")
        expect(post.meta_description).to eq ("You have spent months dreaming and planning your bike journey. You've poured over maps and shopped for gear. You've trained well hopefully you have. There i ...")
      end

      it "does not amend the post meta description if one is already entered" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, meta_description: RandomData.random_sentence)
        expect(post.meta_description).to eq (post.meta_description)
      end
    end

    describe "#draft?" do
      it "returns true if the post published at value is nil" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: nil)
        expect(post.draft?).to be_truthy
      end
      it "returns false if post published at value is present" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: 2.days.ago)
        expect(post.draft?).to be_falsey
      end
    end

    describe "#published?" do
      it "returns true if the post published at time date is in the past" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: 2.days.ago)
        expect(post.published?).to be_truthy
      end
      it "returns false if published at is not present" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: nil)
        expect(post.published?).to be_falsey
      end
      it "returns false if published at is in the future" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: 2.days.from_now)
        expect(post.published?).to be_falsey
      end
    end

    describe "#scheduled?" do
      it "returns true if the post published at time date is in the future" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: 2.days.from_now)
        expect(post.scheduled?).to be_truthy
      end
      it "returns false if the post published at time date is in the past" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: 2.days.ago)
        expect(post.scheduled?).to be_falsey
      end
      it "returns false if post status is not present" do
        post = Post.create(title: RandomData.random_sentence, body: RandomData.random_sentence, published_at: nil)
        expect(post.scheduled?).to be_falsey
      end
    end

    describe "#status" do
      it "returns draft" do
        post = Post.new(published_at: nil)
        expect(post.status).to eq "draft"
      end
      it "returns published" do
        post = Post.new(published_at: Time.current )
        expect(post.status).to eq "published"
      end
      it "returns scheduled" do
        post = Post.new(published_at: 2.days.from_now)
        expect(post.status).to eq "scheduled"
      end
    end

    describe "#assign_attributes" do
      it "sets published_at to nil when draft" do
        post = create(:post, published_at: Time.current)

        post.assign_attributes(status: 'draft')

        expect(post.published_at).to be_nil
      end

      it "sets published_at to current time when published" do
        post = create(:post, published_at: nil)

        freeze_time
        post.assign_attributes(status: 'published')

        expect(post.published_at).to eq Time.current
      end

      it "does not change status or published_at when updating non-publish options" do
        freeze_time
        post = create(:post, published_at: 2.days.ago)

        post.assign_attributes(title: 'Choosing a frameset for your first adventure bike')

        expect(post.published_at).to eq 2.days.ago
        expect(post.status).to eq "published"
        expect(post.title).to eq 'Choosing a frameset for your first adventure bike'
      end

      it "does not change status or published_at when post is scheduled" do
        freeze_time
        post = create(:post, published_at: 1.hour.ago)

        post.assign_attributes(status: 'scheduled', published_at: 2.weeks.from_now)

        expect(post.published_at).to eq 2.weeks.from_now
        expect(post.status).to eq "scheduled"
      end
    end
  end
end
