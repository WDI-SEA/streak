class MainController < ApplicationController
  def index
    redirect_to leaderboard_path if current_user
  end

  def leaderboard
    @users = User.where(cohort: current_user.cohort).joins(:event_snapshots)
  end
end
