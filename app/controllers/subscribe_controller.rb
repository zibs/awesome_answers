class SubscribeController < ApplicationController

  def index
    # this renders a template with no layout
    # render "/welcome/about", layout: false
    # @params
  end

  def create
    redirect_to action: index, status: 303
    flash[:success] = "Account Subscribed!!"
  end

end
