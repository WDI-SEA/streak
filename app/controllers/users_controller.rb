class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
