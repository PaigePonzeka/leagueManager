class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
    add_column :players, :remember_token, :string
    add_index  :players, :remember_token
  end
end
