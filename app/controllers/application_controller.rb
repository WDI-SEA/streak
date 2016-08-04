class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path, :notice => 'You need to sign in with Github'
    end
  end
end
