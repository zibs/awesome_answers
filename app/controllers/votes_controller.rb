class VotesController < ApplicationController
  before_action :authenticate_user

  def create
    question = Question.find(params[:question_id])
    vote = Vote.new(vote_params)
    vote.user = current_user
    vote.question = question
    # flash = (vote.save) ? { notice: "Voted!" } : { alert: "Try Again!" }
    # redirect_to question_path(question), flash
    if vote.save
      redirect_to question_path(question), flash: { success: "Voted!"}
    else
      redirect_to question_path(question), flash: {warning: "Try Again"}
    end
  end

  def update
    question = Question.find(params[:question_id])
    vote     = current_user.votes.find(params[:id])
    vote.update(vote_params)
    redirect_to question_path(question), flash: { info: "Updated!"}
    # else
    #   redirect_to question_path(question), flash: { info: "Try again!"}
    # end
  end

  def destroy
    vote = current_user.votes.find(params[:id])
    vote.destroy
    redirect_to question_path(params[:question_id]), flash: {danger: "Unvoted"}
  end

    private

      def vote_params
        params.require(:vote).permit(:up)
      end


end
