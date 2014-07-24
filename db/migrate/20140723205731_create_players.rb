class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.string :picture_url
      t.string :team
      t.string :stat_year
      t.integer :rushes
      t.integer :rush_yards
      t.integer :rush_tds
      t.integer :targets
      t.integer :receptions
      t.integer :receiving_yards
      t.integer :receiving_tds
      t.integer :completions
      t.integer :attempts
      t.integer :pass_yards
      t.integer :pass_tds
      t.integer :interceptions
      t.integer :sacks
      t.integer :fumble_recoveries
      t.integer :points_against
      t.integer :yards_against
      t.integer :kicking_attempts_1_to_39
      t.integer :kicking_completions_1_to_39
      t.integer :kicking_attempts_40_to_49
      t.integer :kicking_completions_40_to_49
      t.integer :kicking_attempts_over_50
      t.integer :kicking_completions_over_50
      t.integer :kicking_attempts_total
      t.integer :kicking_completions_total
      t.integer :kicking_attempts_XP
      t.integer :kicking_completions_XP
      t.integer :fpoints

      t.timestamps
    end
  end
end
