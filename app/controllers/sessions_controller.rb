class SessionsController < ApplicationController
# don't need a corresponding model
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      # session[:user_id] = user.id
      sign_in(user)
      redirect_to root_path, notice: "Signed In!"
    else
      flash[:alert] = "Wrong credentials!"
      render :new
    end
    # render json: params
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end

end
