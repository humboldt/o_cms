require 'rails_helper'

module OCms
  RSpec.describe PostsController, type: :controller do
    routes { OCms::Engine.routes }
    let(:new_post) { create(:post) }

    context "admin doing CRUD on a post" do
      login_admin

      describe "GET new" do
        it "returns http success" do
          get :new
          expect(response).to have_http_status(:success)
        end

        it "renders the #new view" do
          get :new
          expect(response).to render_template :new
        end

        it "instantiates @post" do
          get :new
          expect(assigns(:post)).not_to be_nil
        end
      end

      describe "POST create" do
        let(:image) { create(:image) }

        it "increases the number of Posts by 1" do
          expect{ post :create, post: {title: RandomData.random_sentence, slug: RandomData.random_slug, body: RandomData.random_paragraph, excerpt: RandomData.random_paragraph, featured_image: image.file.featured, meta_title: RandomData.random_sentence, meta_description: RandomData.random_paragraph, meta_keywords: RandomData.random_word + ',' + RandomData.random_word + ',' + RandomData.random_word } }.to change(Post,:count).by(1)
        end

        it "assigns the new post to @post" do
          post :create, post: {title: RandomData.random_sentence, slug: RandomData.random_slug, body: RandomData.random_paragraph, excerpt: RandomData.random_paragraph, featured_image: image.file.featured, meta_title: RandomData.random_sentence, meta_description: RandomData.random_paragraph, meta_keywords: RandomData.random_word + ',' + RandomData.random_word + ',' + RandomData.random_word }
          expect(assigns(:post)).to eq Post.last
        end

        it "redirects to the new post" do
          post :create, post: {title: RandomData.random_sentence, slug: RandomData.random_slug, body: RandomData.random_paragraph, excerpt: RandomData.random_paragraph, featured_image: image.file.featured, meta_title: RandomData.random_sentence, meta_description: RandomData.random_paragraph, meta_keywords: RandomData.random_word + ',' + RandomData.random_word + ',' + RandomData.random_word }
          expect(response).to redirect_to edit_post_path(Post.last)
        end
      end

      describe "GET edit" do
        it "returns http success" do
          get :edit, id: new_post.id
          expect(response).to have_http_status(:success)
        end

        it "renders the #edit view" do
          get :edit, id: new_post.id
          expect(response).to render_template :edit
        end

        it "assigns post to be updated to @post" do
          get :edit, id: new_post.id
          post_instance = assigns(:post)

          expect(post_instance).to eq new_post
        end
      end

      describe "PUT update" do
        it "updates post with expected attributes" do
          new_title = RandomData.random_sentence
          new_slug = RandomData.random_slug
          new_body = RandomData.random_paragraph
          new_excerpt = RandomData.random_paragraph
          new_featured_image = RandomData.random_slug + '.jpg'
          new_meta_title = RandomData.random_sentence
          new_meta_description = RandomData.random_sentence
          new_meta_keywords = RandomData.random_word + ',' + RandomData.random_word

          put :update, id: new_post.id, post: {title: new_title, slug: new_slug, body: new_body, excerpt: new_excerpt, featured_image: new_featured_image, meta_title: new_meta_title, meta_description: new_meta_description, meta_keywords: new_meta_keywords }

          updated_post = assigns(:post)
          expect(updated_post.id).to eq new_post.id
          expect(updated_post.title).to eq new_title
          expect(updated_post.slug).to eq new_slug
          expect(updated_post.body).to eq new_body
          expect(updated_post.excerpt).to eq new_excerpt
          expect(updated_post.featured_image).to eq new_featured_image
          expect(updated_post.meta_title).to eq new_meta_title
          expect(updated_post.meta_description).to eq new_meta_description
          expect(updated_post.meta_keywords).to eq new_meta_keywords
        end

        it "redirects to the updated post" do
          new_title = RandomData.random_sentence
          new_slug = RandomData.random_slug
          new_body = RandomData.random_paragraph
          new_excerpt = RandomData.random_paragraph
          new_featured_image = RandomData.random_slug + '.jpg'
          new_meta_title = RandomData.random_sentence
          new_meta_description = RandomData.random_sentence
          new_meta_keywords = RandomData.random_word + ',' + RandomData.random_word

          put :update, id: new_post.id, post: {title: new_title, slug: new_slug, body: new_body, excerpt: new_excerpt, featured_image: new_featured_image, meta_title: new_meta_title, meta_description: new_meta_description, meta_keywords: new_meta_keywords }
          expect(response).to redirect_to edit_post_path(new_post)
        end
      end

      describe "DELETE destroy" do
        it "deletes the post" do
          delete :destroy, id: new_post.id
          count = Post.where({id: new_post.id}).size
          expect(count).to eq 0
        end

        it "redirects to posts index" do
          delete :destroy, id: new_post.id
          expect(response).to redirect_to posts_path
        end
      end
    end

  end
end
