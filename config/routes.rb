Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # root page
  root :to => 'top#index'

  # セッション
  # resources :sessions
  get    'user/sign_in'   => 'sessions#new'
  post   'user/sign_in'   => 'sessions#create'
  delete 'user/sign_out'  => 'sessions#destroy'

  # 写真
  resources :posts

  # oauth
  resources :oauth do
    collection do
      get 'callback' => 'oauth#gettoken'
    end
  end
end
