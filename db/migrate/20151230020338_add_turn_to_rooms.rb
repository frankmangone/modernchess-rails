class AddTurnToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :turn, :string
  end
end
