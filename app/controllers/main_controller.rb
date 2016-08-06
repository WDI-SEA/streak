class MainController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    redirect_to leaderboard_path if current_user
  end

  def leaderboard
    if current_user
      @users = User.where(cohort: current_user.cohort)
                   .includes(:event_snapshots)
                   .order('event_snapshots.last_push DESC')
    else
      @users = []
    end
  end
end
