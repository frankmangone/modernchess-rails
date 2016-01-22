class AddUrlTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :url_token, :string
  end
end
