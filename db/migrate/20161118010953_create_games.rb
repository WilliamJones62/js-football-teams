class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.datetime :date
      t.string :opponent

      t.timestamps
    end
  end
end
