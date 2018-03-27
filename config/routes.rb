Rails.application.routes.draw do
  resources :myfiles do
    collection do
      get :bulk_upload
    end
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root 'blogs#index'
  resources :blogs do
    collection do
      get :download_xlsx
      get :send_xlsx
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
