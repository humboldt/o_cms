require 'rails_helper'

module OCms
  RSpec.describe GalleriesController, type: :controller do
    routes { OCms::Engine.routes }
    let(:gallery) { create(:gallery) }

    context "user doing CRUD on a gallery" do
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

        it "instantiates @gallery" do
          get :new
          expect(assigns(:gallery)).not_to be_nil
        end
      end

      describe "POST create" do
        it "increases the number of Gallerys by 1" do
          expect{ post :create, gallery: {name: RandomData.random_sentence, description: RandomData.random_paragraph } }.to change(Gallery,:count).by(1)
        end

        it "assigns the new gallery to @gallery" do
          post :create, gallery: {name: RandomData.random_sentence, description: RandomData.random_paragraph }
          expect(assigns(:gallery)).to eq Gallery.last
        end

        it "redirects to the new gallery" do
          post :create, gallery: {name: RandomData.random_sentence, description: RandomData.random_paragraph }
          expect(response).to redirect_to edit_gallery_path(Gallery.last)
        end
      end

      describe "GET edit" do
        it "returns http success" do
          get :edit, id: gallery.id
          expect(response).to have_http_status(:success)
        end

        it "renders the #edit view" do
          get :edit, id: gallery.id
          expect(response).to render_template :edit
        end

        it "assigns gallery to be updated to @gallery" do
          get :edit, id: gallery.id
          gallery_instance = assigns(:gallery)

          expect(gallery_instance).to eq gallery
        end
      end

      describe "PUT update" do
        it "updates gallery with expected attributes" do
          new_name = RandomData.random_sentence
          new_description = RandomData.random_paragraph

          put :update, id: gallery.id, gallery: {name: new_name, description: new_description }

          updated_gallery = assigns(:gallery)
          expect(updated_gallery.id).to eq gallery.id
          expect(updated_gallery.name).to eq new_name
          expect(updated_gallery.description).to eq new_description
        end

        it "redirects to the updated gallery" do
          new_name = RandomData.random_sentence
          new_description = RandomData.random_paragraph

          put :update, id: gallery.id, gallery: {name: new_name, description: new_description }
          expect(response).to redirect_to edit_gallery_path(gallery)
        end
      end

      describe "DELETE destroy" do
        it "deletes the gallery" do
          delete :destroy, id: gallery.id
          count = Gallery.where({id: gallery.id}).size
          expect(count).to eq 0
        end

        it "redirects to galleries index" do
          delete :destroy, id: gallery.id
          expect(response).to redirect_to galleries_path
        end
      end
    end
  end
end
