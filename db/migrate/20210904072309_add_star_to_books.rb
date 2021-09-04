class AddStarToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :star, :float
  end
end
