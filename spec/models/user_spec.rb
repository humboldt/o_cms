require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, :admin) }

  describe "attributes" do
    it "should have email attribute" do
      expect(user).to have_attributes(email: user.email)
    end

    it "responds to has_role?" do
      expect(user).to respond_to(:has_role?)
    end

    it "has admin user has admin role" do
      expect(admin_user.has_role?(:admin)).to eq true
    end

    it "default user does not have the admin role" do
      expect(user.has_role?(:admin)).to eq false
    end
  end
end
