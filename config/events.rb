WebsocketRails::EventMap.describe do
  namespace :api do
    namespace :v1 do
      namespace :modernchess do
        subscribe :load_room,       to: ModernchessRoomsController, with_method: :load_room
        subscribe :calculate_moves, to: ModernchessRoomsController, with_method: :calculate_moves
        subscribe :make_move,       to: ModernchessRoomsController, with_method: :make_move
      end

      namespace :chess do
        
      end

    end
  end
end
