module OCms
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate_admin!

    # Redirects any unauthorised users
    def authenticate_admin!
      if user_signed_in? 
        unless current_user.has_role? :admin 
          flash[:alert] = "Sorry your are not authorized to view this area."
          redirect_to main_app.root_url
        end
       else
        authenticate_user!
       end
    end
  end
end