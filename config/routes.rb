Memorizr::Application.routes.draw do
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

  resources :settings do
    collection do
      get :edit_password
      put :update_password
    end
  end
  
  root :to => "words#index"
end
