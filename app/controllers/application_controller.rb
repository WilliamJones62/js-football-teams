class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_team

  def current_team
    session[:team_id] ||= []
  end

  def current_player
    session[:player_id] ||= []
  end
end
