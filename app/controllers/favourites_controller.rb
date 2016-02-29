class FavouritesController < ApplicationController
  before_action :authenticate_user

  def index
    @favourites = current_user.favourited_questions.order("created_at DESC")
  end

  def create
    @question = Question.find(params[:question_id])
    favourite = Favourite.new(question: @question, user: current_user)
    respond_to do |format|
      if favourite.save
        format.html { redirect_to @question, flash: { success: "<3"} }
        format.js { render :successful_favourite }
      else
        format.html { redirect_to @question, flash: { info: "already <3ed"} }
        format.js { render :unsuccessful_favourite }
      end
    end
  end

  def destroy
    favourite = current_user.favourites.find(params[:id])
    @question = Question.find(params[:question_id])
    favourite.destroy
    respond_to do |format|
      format.html { redirect_to question_path(params[:question_id]), flash: {warning: "un<3ed"} }
      format.js { render }
    end
  end

end
