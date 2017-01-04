class PlayerGamesController < ApplicationController

  def new
    @player_game = PlayerGame.new
    @team = Team.find(current_team)
    @player = Player.find(current_player)
    @games = @team.games.all
  end

  def create
    @player_game = PlayerGame.new(player_game_params)
    respond_to do |format|
      if @player_game.save
        @team = current_team
        @player = current_player
        format.html { redirect_to @player_game, notice: 'Game rating was successfully created.' }
      else
        format.html {
          flash[:error] = @player_game.errors.full_messages.first
          render :new
        }
      end
    end
  end

  def show
    @team = Team.find(current_team)
    @player_game = PlayerGame.find(params[:id])
    @player = Player.find(current_player)
  end

  def edit
  end

  def update
    respond_to do |format|
      if @player_game.update(player_game_params)
        format.html { redirect_to @player_game, notice: 'Player/game was successfully updated.' }
      else
        format.html {
          flash[:error] = @player_game.errors.full_messages.first
          render :edit
        }
      end
    end
  end

  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to player_games_url, notice: 'Player/game was successfully destroyed.' }
    end
  end

private
  def player_game_params
    params.require(:player_game).permit(
      :player_rating, :player_id, :game_id
    )
  end
end
