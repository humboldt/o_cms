require 'rails_helper'

module OCms
  RSpec.describe PagesController, type: :controller do
    routes { OCms::Engine.routes }
    let(:page) { create(:page) }

    context "user doing CRUD on a page" do
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

        it "instantiates @page" do
          get :new
          expect(assigns(:page)).not_to be_nil
        end
      end

      describe "POST create" do
        let(:image) { create(:image) }

        it "increases the number of Pages by 1" do
          expect{ post :create, page: {title: RandomData.random_sentence, slug: RandomData.random_slug, body: RandomData.random_paragraph, excerpt: RandomData.random_paragraph, featured_image: image.file.featured.to_s, meta_title: RandomData.random_sentence, meta_description: RandomData.random_paragraph, meta_keywords: RandomData.random_word + ',' + RandomData.random_word + ', ' + RandomData.random_word } }.to change(Page,:count).by(1)
        end

        it "assigns the new page to @page" do
          post :create, page: {title: RandomData.random_sentence, slug: RandomData.random_slug, body: RandomData.random_paragraph, excerpt: RandomData.random_paragraph, featured_image: image.file.featured.to_s, meta_title: RandomData.random_sentence, meta_description: RandomData.random_paragraph, meta_keywords: RandomData.random_word + ',' + RandomData.random_word + ', ' + RandomData.random_word }
          expect(assigns(:page)).to eq Page.last
        end

        # Erroring - Vlaue too long for character
        it "redirects to the new page" do
          post :create, page: {title: RandomData.random_sentence, slug: RandomData.random_slug, body: RandomData.random_paragraph, excerpt: RandomData.random_paragraph, featured_image: image.file.featured.to_s, meta_title: RandomData.random_sentence, meta_description: RandomData.random_paragraph, meta_keywords: RandomData.random_word + ',' + RandomData.random_word + ', ' + RandomData.random_word }

          expect(response).to redirect_to edit_page_path(Page.last)
        end
      end

      describe "GET edit" do
        it "returns http success" do
          get :edit, id: page.id
          expect(response).to have_http_status(:success)
        end

        it "renders the #edit view" do
          get :edit, id: page.id
          expect(response).to render_template :edit
        end

        it "assigns page to be updated to @page" do
          get :edit, id: page.id
          page_instance = assigns(:page)

          expect(page_instance).to eq page
        end
      end

      describe "PUT update" do
        it "updates page with expected attributes" do
          new_title = RandomData.random_sentence
          new_slug = RandomData.random_slug
          new_body = RandomData.random_paragraph
          new_excerpt = RandomData.random_paragraph
          new_featured_image = RandomData.random_slug + '.jpg'
          new_meta_title = RandomData.random_sentence
          new_meta_description = RandomData.random_paragraph
          new_meta_keywords = RandomData.random_word + ',' + RandomData.random_word

          put :update, id: page.id, page: {title: new_title, slug: new_slug, body: new_body, excerpt: new_excerpt, featured_image: new_featured_image, meta_title: new_meta_title, meta_description: new_meta_description, meta_keywords: new_meta_keywords }

          updated_page = assigns(:page)
          expect(updated_page.id).to eq page.id
          expect(updated_page.title).to eq new_title
          expect(updated_page.slug).to eq new_slug
          expect(updated_page.body).to eq new_body
          expect(updated_page.excerpt).to eq new_excerpt
          expect(updated_page.featured_image).to eq new_featured_image
          expect(updated_page.meta_title).to eq new_meta_title
          expect(updated_page.meta_description).to eq new_meta_description
          expect(updated_page.meta_keywords).to eq new_meta_keywords
        end

        it "redirects to the updated page" do
          new_title = RandomData.random_sentence
          new_slug = RandomData.random_slug
          new_body = RandomData.random_paragraph
          new_excerpt = RandomData.random_paragraph
          new_featured_image = RandomData.random_slug + '.jpg'
          new_meta_title = RandomData.random_sentence
          new_meta_description = RandomData.random_paragraph
          new_meta_keywords = RandomData.random_word + ',' + RandomData.random_word

          put :update, id: page.id, page: {title: new_title, slug: new_slug, body: new_body, excerpt: new_excerpt, featured_image: new_featured_image, meta_title: new_meta_title, meta_description: new_meta_description, meta_keywords: new_meta_keywords }
          expect(response).to redirect_to edit_page_path(page)
        end
      end

      describe "DELETE destroy" do
        it "deletes the page" do
          delete :destroy, id: page.id
          count = Page.where({id: page.id}).size
          expect(count).to eq 0
        end

        it "redirects to pages index" do
          delete :destroy, id: page.id
          expect(response).to redirect_to pages_path
        end
      end
    end

    end
    end
