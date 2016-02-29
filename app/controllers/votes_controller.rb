class VotesController < ApplicationController
  before_action :authenticate_user

  def create
    @question = Question.find(params[:question_id])
    vote = Vote.new(vote_params)
    vote.user = current_user
    vote.question = @question
    # flash = (vote.save) ? { notice: "Voted!" } : { alert: "Try Again!" }
    # redirect_to question_path(question), flash
    respond_to do |format|
      if vote.save
        format.html { redirect_to question_path(@question), flash: { success: "Voted!"} }
        format.js { render :successful_vote }
      else
        format.html { redirect_to question_path(@question), flash: {warning: "Try Again"} }
        format.js { render :unsuccessful_vote }
      end
    end
  end

  def update
    @question = Question.find(params[:question_id])
    vote     = current_user.votes.find(params[:id])
    respond_to do |format|
      if vote.update(vote_params)
        format.html {redirect_to question_path(@question), flash: { info: "Updated!"} }
        format.js { render :successful_vote_update }
      else
        format.html { redirect_to question_path(@question), flash: { info: "try again!"} }
        format.js { render :unsuccessful_vote_update }
      end
    end
  end

  def destroy
    vote = current_user.votes.find(params[:id])
    @question = Question.find(params[:question_id])
    vote.destroy
    respond_to do |format|
      format.html { redirect_to question_path(params[:question_id]), flash: {danger: "Unvoted"} }
      format.js { render }
    end
  end

    private

      def vote_params
        params.require(:vote).permit(:up)
      end


end
