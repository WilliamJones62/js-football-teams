class CreatePlayerGames < ActiveRecord::Migration[5.0]
  def change
    create_table :player_games do |t|
      t.integer :player_id
      t.integer :game_id
      t.integer :player_rating

      t.timestamps
    end
  end
end
