class Team < ActiveRecord::Base
  has_many :players, inverse_of: :team, :dependent => :destroy
  accepts_nested_attributes_for :players
  has_many :games, inverse_of: :team, :dependent => :destroy
  accepts_nested_attributes_for :games
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :league, presence: true

  before_save :erase_empty_players_and_games

  def player_attributes=(player)
    self.player = Player.find_or_create_by(name: player.name)
    self.player.update(player)
  end

  def erase_empty_players_and_games
    self.players = self.players.select {|i| i.name && i.name != ''}
    self.games = self.games.select {|i| i.date && i.date != ''}
  end

  def player_with_most_games
    save_count = 0
    save_player = ''
    self.players.each do |player|
      current_count = player.player_games.count
      if current_count > save_count
        save_count = current_count
        save_player = player
      end
    end
    save_player
  end

  def best_player
    save_rating = 0
    save_player = ''
    self.players.each do |player|
      if player.player_games.count > 0
        current_rating = player.player_games.average(:player_rating)
        if current_rating > save_rating
          save_rating = current_rating
          save_player = player
        end
      end
    end
    save_player
  end

 end
