class AddScoreAgainstToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :score_against, :integer
  end
end
