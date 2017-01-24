class GamesController < ApplicationController

  before_action :set_team

  def create
    @game = @team.games.build(games_params)
    if @game.save
#      render 'games/basic', layout: false
      render :json => @game
    end
  end

  def index
    @games = @team.games
    render :json => @games
  end

  def show
    @game = Game.find(params[:id])
    @team = @game.team
    session[:team_id] = @team.id
    session[:game_id] = @game.id
    @players = @game.players.all
  end

  private
    def set_team
      @team = Team.find(params[:team_id])
    end

    def games_params
      params.require(:game).permit(:date, :opponent, :score_for, :score_against, :home_away)
    end

end
