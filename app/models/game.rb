class Game < ActiveRecord::Base
  belongs_to :team, :foreign_key => "team_id"
  has_many :player_games
  has_many :players, through: :player_games
end
