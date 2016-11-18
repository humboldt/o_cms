Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  root to: "welcome#index"
  devise_scope :user do
    get "/users/sign_out" => "users/sessions#destroy"
  end

  authenticate :user do
    mount OCms::Engine => '/o_cms'
  end
end
