class CohortsController < ApplicationController
  def index
    @cohorts = Cohort.order(created_at: :desc)
  end

  def show
    @cohort = Cohort.find(params[:id])
  end
end
