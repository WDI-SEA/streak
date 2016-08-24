class MainController < ApplicationController
  before_action :authenticate_user!, except: [:index, :letsencrypt]

  def index
    redirect_to leaderboard_path if current_user
  end

  def leaderboard
    @cohorts = Cohort.order(:name) if current_user.admin?
  end

  def letsencrypt
    render text: ENV['LETS_ENCRYPT'] || 'Nothing provided. Set the LETS_ENCRYPT environment variable'
  end
end
