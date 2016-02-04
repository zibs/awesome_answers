class WelcomeController < ApplicationController

  def index
  end

  def about
  end

  def greet
    @name = params[:name]
  end

end
