Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :modernchess do
        namespace :rooms do
          get   '/' => 'modernchess_rooms#index'
          match  '/', to: 'modernchess_rooms#create', via: [:post, :options]
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