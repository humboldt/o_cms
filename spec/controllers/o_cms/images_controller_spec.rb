require 'rails_helper'

module OCms
  RSpec.describe ImagesController, type: :controller do
    routes { OCms::Engine.routes }
    let(:my_image) { create(:image) }

    context "guest" do
      describe "GET show" do
        it "returns http redirect" do
          get :show, id: my_image.id
          expect(response).to redirect_to(main_app.user_session_path)
        end
      end
    end

    context "member user doing CRUD on a image they don't own" do
      login_user

      describe "GET show" do
        it "returns http success" do
          get :show, id: my_image.id
          expect(response).to redirect_to(main_app.root_path)
        end
      end
    end

    context "admin user doing CRUD on a image they own" do
      login_admin

      describe "GET show" do
        it "returns http success" do
          get :show, id: my_image.id
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
