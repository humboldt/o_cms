require_dependency "o_cms/application_controller"

module OCms
  class DashboardController < ApplicationController
    before_action :authenticate_admin!

    def index
    end
  end
end
