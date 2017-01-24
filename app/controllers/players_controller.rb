class PlayersController < ApplicationController

  before_action :set_team

  def player_data
    post = Post.find(params[:id])
    render json: post.to_json
  end

  def create
    @player = @team.players.build(players_params)
    if @player.save
#      render 'players/basic', layout: false
      render :json => @player
    end
  end

  def index
    @players = @team.players
    render :json => @players
  end

  def show
    @player = Player.find(params[:id])
    @team = @player.team
    @players = @team.players
    @player_ids = []
    @prev_id = -1
    @next_id = -1
    @current_player_offset = -1
    # load the player id array
    @team.players.each do |player|
      @player_ids << player.id
      if player.id == @player.id
        @current_player_offset = @player_ids.count - 1
      end
    end
    #load the previous and next player ids from the array
    if @current_player_offset != 0
      @prev_id = @player_ids[@current_player_offset - 1]
    end
    if @current_player_offset != @player_ids.count - 1
      @next_id = @player_ids[@current_player_offset + 1]
    end

    session[:team_id] = @team.id
    session[:player_id] = @player.id
    @games = @player.games.all
  end

  def data
    player = Player.find(params[:id])
    render json: player.to_json(only: [:name, :id],
                              include: [ games: { only: [:date, :id, :opponent]}])
  end

  private
    def set_team
      @team = Team.find(params[:team_id])
    end

    def players_params
      params.require(:player).permit(:name)
    end

end
