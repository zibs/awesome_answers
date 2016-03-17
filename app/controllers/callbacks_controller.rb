class CallbacksController < ApplicationController

  def twitter
    # search for the user with their uid/provider, if we find them then we log the user in and otherwise we create a new user account
    omniauth_data = request.env['omniauth.auth']
    user = User.find_twitter_user(omniauth_data)
    user ||= User.create_from_twitter(omniauth_data)
    user_sign_in(user)
    redirect_to root_path, flash: {success: "Signed In" }
    # if user
    # else
    #   user = User.create_from_twitter(omniauth_data)
    # end
    # refactored
  end

end
# render json: omniauth_data
