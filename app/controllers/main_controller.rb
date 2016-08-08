class MainController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    redirect_to leaderboard_path if current_user
  end

  def leaderboard
    @cohorts = Cohort.order(:name) if current_user.admin?
  end
end
