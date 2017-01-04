class AddHomeAwayToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :home_away, :string
  end
end
