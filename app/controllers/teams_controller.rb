class TeamsController < ApplicationController

  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :signed_in?, only: [:new, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
    @players = @team.players
    13.times { @team.players.build }
    46.times { @team.games.build }
  end

  def edit
    @players = @team.players
#    @player = @team.players.build
#    @game = @team.games.build
  end

  def create
    @team = Team.new(team_params)
    @team.user_id = current_user.id
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
      else
        format.html {
          flash[:error] = @team.errors.full_messages.first
          render :new
        }
      end
    end
  end

  def show
    @team = Team.find(params[:id])
    if @team.players.last.try(:name)
      @team.players.build
      @most_played = @team.player_with_most_games
      @best_player = @team.best_player
    end
    if @team.games.last.try(:date)
      @team.games.build
    end
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
      else
        format.html {
          flash[:error] = @team.errors.full_messages.first
          render :edit
        }
      end
    end
  end

  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
    end
  end

private
    def set_team
      @team = Team.find(params[:id])
      session[:team_id] = @team_id
    end

    def team_params
      params.require(:team).permit(
        :name, :league,
        players_attributes: [
          :id,
          :name
        ],
        games_attributes: [
          :id,
          :date,
          :opponent,
          :score_for,
          :score_against,
          :home_away
        ]
      )
    end

    def signed_in?
      unless current_user
        redirect_to teams_path, :alert => "Access denied."
      end
    end

    def authorize_user!
      unless current_user.id == @team.user_id || current_user.admin?
        redirect_to team_path(id: @team.id), :alert => "Access denied."
      end
    end
end
