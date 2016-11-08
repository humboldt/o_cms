require 'rails_helper'

module OCms
  RSpec.describe ImagesController, type: :controller do
    routes { OCms::Engine.routes }
    let(:image) { create(:image) }

    context "admin doing CRUD on an image" do
      login_admin

      describe "GET show" do
        it "returns http success" do
          get :show, id: image.id
          expect(response).to have_http_status(:success)
        end

        it "renders the #show view" do
          get :show, id: image.id
          expect(response).to render_template :show
        end

        it "assigns image to @image" do
          get :show, id: image.id
          expect(assigns(:image)).to eq(image)
        end
      end

      describe "GET new" do
        it "returns http success" do
          get :new
          expect(response).to have_http_status(:success)
        end

        it "renders the #new view" do
          get :new
          expect(response).to render_template :new
        end

        it "instantiates @image" do
          get :new
          expect(assigns(:image)).not_to be_nil
        end
      end

      describe "POST create" do
        let(:file) { fixture_file_upload('files/mountains.jpg', 'image/jpeg') }

        it "increases the number of Images by 1" do
          expect{ post :create, image: {name: RandomData.random_sentence, file: file, description: RandomData.random_paragraph} }.to change(Image,:count).by(1)
        end

        it "assigns the new image to @image" do
          post :create, image: {name: RandomData.random_sentence, file: file, description: RandomData.random_paragraph}
          expect(assigns(:image)).to eq Image.last
        end

        it "redirects to the new image" do
          post :create, image: {name: RandomData.random_sentence, file: file, description: RandomData.random_paragraph}
          expect(response).to redirect_to Image.last
        end
      end

      describe "GET edit" do
        it "returns http success" do
          get :edit, id: image.id
          expect(response).to have_http_status(:success)
        end

        it "renders the #edit view" do
          get :edit, id: image.id
          expect(response).to render_template :edit
        end

        it "assigns image to be updated to @image" do
          get :edit, id: image.id
          image_instance = assigns(:image)

          expect(image_instance).to eq image
        end
      end

      describe "PUT update" do
        it "updates image with expected attributes" do
          new_name = RandomData.random_sentence
          new_file = RandomData.random_slug + '.jpg'
          new_description = RandomData.random_paragraph

          put :update, id: image.id, image: {name: new_name, file: new_file, description: new_description}

          updated_image = assigns(:image)
          expect(updated_image.id).to eq image.id
          expect(updated_image.name).to eq new_name
          expect(updated_image.description).to eq new_description
        end

        it "redirects to the updated image" do
          new_name = RandomData.random_sentence
          new_file = fixture_file_upload('files/mountains.jpg', 'image/jpeg')
          new_description = RandomData.random_paragraph

          put :update, id: image.id, image: {name: new_name, file: new_file, description: new_description}
          expect(response).to redirect_to image
        end
      end

      describe "DELETE destroy" do
        it "deletes the image" do
          delete :destroy, id: image.id
          count = Image.where({id: image.id}).size
          expect(count).to eq 0
        end

        it "redirects to images index" do
          delete :destroy, id: image.id
          expect(response).to redirect_to images_path
        end
      end
    end
  end
end
