class AddEmailPasswordToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :email, :string
    add_column :players, :password_digest, :string
  end
end
