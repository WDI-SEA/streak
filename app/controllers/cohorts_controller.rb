class CohortsController < ApplicationController
  before_action :admin!

  def index
    @cohorts = Cohort.order(created_at: :desc)
  end

  def new
    @cohort = Cohort.new
  end

  def show
    @cohort = Cohort.find(params[:id])
  end

  def edit
    @cohort = Cohort.find(params[:id])
  end
end
