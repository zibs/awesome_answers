class WelcomeController < ApplicationController

  def index
  end

  def about
    # encrypts cookies
    cookies.signed[:abc] = "xyz"
    cookies.signed[:hello] = "good bye"
    session[:foo] = "bar"

    # session stores everything in a single session value - a single cookie with entire hash which gets decrypted on the server side. Slightly more efficient, slightly more secure. No hints of what keys/values are.
    
  end

  def greet

    @name = params[:name]
    Rails.logger.info ">>>>>>>>>>>>>>>"

    Rails.logger.info cookies.signed[:hello]
    Rails.logger.info ">>>>>>>>>>>>>>>"
  end

end
