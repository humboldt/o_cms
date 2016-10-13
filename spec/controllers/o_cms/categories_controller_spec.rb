require 'rails_helper'

module OCms
  RSpec.describe CategoriesController, type: :controller do
    routes { OCms::Engine.routes }
    let(:my_category) { create(:category) }

    context "admin user doing CRUD on a category" do
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

        it "instantiates @category" do
          get :new
          expect(assigns(:category)).not_to be_nil
        end
      end

      describe "POST create" do
        it "increases the number of Categories by 1" do
          expect{ post :create, category: {name: RandomData.random_sentence, slug: RandomData.random_slug, icon: RandomData.random_slug, body: RandomData.random_paragraph, meta_title: RandomData.random_sentence, meta_description: RandomData.random_paragraph, meta_keywords: RandomData.random_word + ', ' + RandomData.random_word + ',' + RandomData.random_word } }.to change(Category,:count).by(1)
        end

        it "assigns the new category to @category" do
          post :create, category: {name: RandomData.random_sentence, slug: RandomData.random_slug, icon: RandomData.random_slug, body: RandomData.random_paragraph, meta_title: RandomData.random_sentence, meta_description: RandomData.random_paragraph, meta_keywords: RandomData.random_word + ', ' + RandomData.random_word + ',' + RandomData.random_word }
          expect(assigns(:category)).to eq Category.last
        end

        it "redirects to the new category" do
          post :create, category: {name: RandomData.random_sentence, slug: RandomData.random_slug, icon: RandomData.random_slug, body: RandomData.random_paragraph, meta_title: RandomData.random_sentence, meta_description: RandomData.random_paragraph, meta_keywords: RandomData.random_word + ', ' + RandomData.random_word + ',' + RandomData.random_word }
          expect(response).to redirect_to edit_category_path(Category.last)
        end
      end

      describe "GET edit" do
        it "returns http success" do
          get :edit, id: my_category.id
          expect(response).to have_http_status(:success)
        end

        it "renders the #edit view" do
          get :edit, id: my_category.id
          expect(response).to render_template :edit
        end

        it "assigns category to be updated to @category" do
          get :edit, id: my_category.id
          category_instance = assigns(:category)

          expect(category_instance).to eq my_category
        end
      end

      describe "PUT update" do
        it "updates category with expected attributes" do
          new_name = RandomData.random_sentence
          new_slug = RandomData.random_slug
          new_icon = RandomData.random_slug
          new_body = RandomData.random_paragraph
          new_meta_title = RandomData.random_sentence
          new_meta_description = RandomData.random_paragraph
          new_meta_keywords = RandomData.random_word + ', ' + RandomData.random_word

          put :update, id: my_category.id, category: {name: new_name, slug: new_slug, icon: new_icon, body: new_body, meta_title: new_meta_title, meta_description: new_meta_description, meta_keywords: new_meta_keywords }

          updated_category = assigns(:category)
          expect(updated_category.id).to eq my_category.id
          expect(updated_category.name).to eq new_name
          expect(updated_category.slug).to eq new_slug
          expect(updated_category.icon).to eq new_icon
          expect(updated_category.body).to eq new_body
          expect(updated_category.meta_title).to eq new_meta_title
          expect(updated_category.meta_description).to eq new_meta_description
          expect(updated_category.meta_keywords).to eq new_meta_keywords
        end

        it "redirects to the updated post" do
          new_name = RandomData.random_sentence
          new_slug = RandomData.random_slug
          new_icon = RandomData.random_slug
          new_body = RandomData.random_paragraph
          new_meta_title = RandomData.random_sentence
          new_meta_description = RandomData.random_paragraph
          new_meta_keywords = RandomData.random_word + ', ' + RandomData.random_word

          put :update, id: my_category.id, category: {title: new_name, slug: new_slug, icon: new_icon, body: new_body, meta_title: new_meta_title, meta_description: new_meta_description, meta_keywords: new_meta_keywords }
          expect(response).to redirect_to edit_category_path(my_category)
        end
      end

      describe "DELETE destroy" do
        it "deletes the category" do
          delete :destroy, id: my_category.id
          count = Post.where({id: my_category.id}).size
          expect(count).to eq 0
        end

        it "redirects to categorys index" do
          delete :destroy, id: my_category.id
          expect(response).to redirect_to categories_path
        end
      end
    end
  end
end
