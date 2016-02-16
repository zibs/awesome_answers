class SessionsController < ApplicationController
# don't need a corresponding model
  def new
  end

  def create
    p params
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # session[:user_id] = user.id
      sign_in(user)
      redirect_to(root_path, flash: { success: "Signed in :)"})
    else
      flash[:danger] = "Wrong credentials!"
      render :new
    end
    # render json: params
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: { warning:  "Logged out" }
  end

end
