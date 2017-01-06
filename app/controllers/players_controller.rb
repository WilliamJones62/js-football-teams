class PlayersController < ApplicationController

  before_action :set_team

  def index
    @players = @team.players
    render :json => @players
  end

  def show
    @player = Player.find(params[:id])
    @team = @player.team
    session[:team_id] = @team.id
    session[:player_id] = @player.id
    @games = @player.games.all
  end

  private
    def set_team
      @team = Team.find(params[:team_id])
    end
end
