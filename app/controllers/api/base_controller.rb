class Api::BaseController < ApplicationController
  before_action :authenticate_api_key

  private

    def authenticate_api_key
      # find the user through the api_key params
      @user = User.find_by(api_key: params[:api_key])
      head :unauthorized unless @user
    end

end
