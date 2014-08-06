class AddSafetyToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :safety, :integer
  end
end
