Memorizr::Application.routes.draw do
  resources :words

  resource :session do
    member do
      get :logout
    end
  end
  
  root :to => "words#index"
end
