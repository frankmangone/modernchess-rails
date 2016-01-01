class AddBoardToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :board, :string
  end
end
