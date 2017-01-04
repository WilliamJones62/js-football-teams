class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @team = @game.team
    session[:team_id] = @team.id
    @players = @game.players.all
  end
end
