class AddSourceToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :source, :string
  end
end
