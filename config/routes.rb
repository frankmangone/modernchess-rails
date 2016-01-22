Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      #devise_for :users, skip: :registration, controllers: { sessions: "users/sessions" }

      namespace :users do
        get '/'           => 'users#index'
        get '/:url_token' => 'users#show'
        match '/',           to: 'users#create', via: [:post, :options]
        match '/:url_token', to: 'users#delete', via: [:delete, :options]

        match '/log_in', to: 'sessions#create', via: [:post, :options]
      end

      namespace :modernchess do
        namespace :rooms do
          get    '/' => 'modernchess_rooms#index'
          get    '/:token' => 'modernchess_rooms#show'
          match  '/', to: 'modernchess_rooms#create', via: [:post, :options]
          match  '/:token', to: 'modernchess_rooms#destroy', via: [:delete, :options]
        end
      end

      namespace :chess do
        namespace :rooms do
          get '/' => 'chess_rooms#index'
        end
      end
      namespace :rollchess do
        
      end
    end
  end
end
