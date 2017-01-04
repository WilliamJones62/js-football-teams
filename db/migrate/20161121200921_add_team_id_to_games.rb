class AddTeamIdToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :team_id, :integer
  end
end
