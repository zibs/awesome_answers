class LikesController < ApplicationController
  before_action :authenticate_user
  

  def create
    question = Question.find(params[:question_id])
    like = Like.new(question: question, user: current_user)
    if like.save
    # current_user.liked_questions << question
      redirect_to question, flash: { success: "Liked" }
    else
    redirect_to question, flash: { info: "Already Liked"}
    end
  end

  def destroy
    like = current_user.likes.find(params[:id])
    like.destroy
    redirect_to question_path(params[:question_id]), flash: { warning: "Unliked"}
  end


end
