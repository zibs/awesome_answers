class FavouritesController < ApplicationController
  before_action :authenticate_user

  def index
    @favourites = current_user.favourited_questions.order("created_at DESC")
  end

  def create
    question = Question.find(params[:question_id])
    favourite = Favourite.new(question: question, user: current_user)
    if favourite.save
      redirect_to question, flash: { success: "<3"}
    else
      redirect_to question, flash: { info: "already <3ed"}
    end
  end

  def destroy
    favourite = current_user.favourites.find(params[:id])
    favourite.destroy
    redirect_to question_path(params[:question_id]), flash: {warning: "un<3ed"}
  end

end
