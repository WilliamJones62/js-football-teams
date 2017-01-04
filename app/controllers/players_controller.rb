class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
    @team = @player.team
    session[:team_id] = @team.id
    session[:player_id] = @player.id
    @games = @player.games.all
  end
end
