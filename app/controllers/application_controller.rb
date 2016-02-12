class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # defining a method inside the application controller makes it available in all controllers in our system. Adding `helper_method` makes this method available in all view files as well!

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||=  User.find(session[:user_id])
  end
  helper_method :current_user

  def sign_in(user)
    session[:user_id] = user.id
  end

end
