class CohortsController < ApplicationController
  before_action :admin!

  def index
    @cohorts = Cohort.order(created_at: :desc)
  end

  def new
    @cohort = Cohort.new
  end

  def create
    @cohort = Cohort.new(cohort_params)
    if @cohort.save
      redirect_to @cohort
    else
      render :new
    end
  end

  def show
    @cohort = Cohort.find(params[:id])
  end

  def edit
    @cohort = Cohort.find(params[:id])
  end

  def update
    @cohort = Cohort.find(params[:id])
    if @cohort.update_attributes(cohort_params)
      redirect_to @cohort
    else
      render :edit
    end
  end

  private

  def cohort_params
    params.require(:cohort).permit(:name, :description, :user_ids => [])
  end
end
