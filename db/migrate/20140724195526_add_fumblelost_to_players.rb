class AddFumblelostToPlayers < ActiveRecord::Migration
  def change
  	add_column :players, :fumble_lost, :integer
  end
end
