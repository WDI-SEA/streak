class MainController < ApplicationController
  def index
    redirect_to leaderboard_path if current_user
  end

  def leaderboard

  end
end
