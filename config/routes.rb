Rails.application.routes.draw do
 
  ails.application.routes.draw do
    resources :applications, only: [:create, :index] do
      resources :chats, only: [:create, :index], param: :application_token do
        resources :messages, only: [:create] do
          collection do
            get :search
          end
        end
      end
    end
end
