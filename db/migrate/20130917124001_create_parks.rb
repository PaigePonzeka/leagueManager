class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
      t.string :url
      t.string :name

      t.timestamps
    end
  end
end
