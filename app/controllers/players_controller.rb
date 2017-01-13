class PlayersController < ApplicationController

  before_action :set_team

  def create
    @player = @team.players.build(players_params)
    if @player.save
      render 'players/basic', layout: false
    end
  end

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

    def players_params
      params.require(:player).permit(:name)
    end

end
