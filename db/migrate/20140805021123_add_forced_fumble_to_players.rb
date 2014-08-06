class AddForcedFumbleToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :forced_fumble, :integer
  end
end
