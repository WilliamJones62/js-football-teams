class ChangeDateDataTypeToGames < ActiveRecord::Migration[5.0]
  def change
    change_column :games, :date, :date
  end
end
