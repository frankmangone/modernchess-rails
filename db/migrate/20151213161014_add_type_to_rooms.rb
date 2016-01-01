class AddTypeToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :game_type, :string
  end
end
