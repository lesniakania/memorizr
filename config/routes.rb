Memorizr::Application.routes.draw do |map|
  resources :words do
    collection do
      post :translate
      post :save
    end
  end

  resource :session do
    member do
      get :logout
    end
  end
  
  root :to => "words#index"
end
