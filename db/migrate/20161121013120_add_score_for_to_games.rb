class AddScoreForToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :score_for, :integer
  end
end
