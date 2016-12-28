Rails.application.routes.draw do

  get 'tags/:tag', to: 'articles#index', as: :tag
  
  resources :articles do
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
