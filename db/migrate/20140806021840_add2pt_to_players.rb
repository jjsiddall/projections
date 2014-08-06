class Add2ptToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :two_pt_conversions, :integer
  end
end
