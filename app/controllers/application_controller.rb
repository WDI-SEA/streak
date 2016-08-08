class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path, :alert => 'You need to sign in with Github'
    end
  end

  def admin!
    if user_signed_in? && current_user.admin?
      self.authenticate_user!
    else
      redirect_to root_path, :alert => 'You need to be an admin to access that page.'
    end
  end
end
