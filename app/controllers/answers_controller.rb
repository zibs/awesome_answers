class AnswersController < ApplicationController
  before_action :find_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user #, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  # don't need that since there are only these actions in the first place...

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)

    @answer.question = @question
    @answer.user = current_user

    # @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to question_path(@question), notice: "Answer created!"
    else
      # rendering into another controller, hardcode
      render "questions/show"
    end
  end

  def edit
  end

  def update

  end

  def destroy
    # to ensure that both question and answer id matches
    # question = Question.find(params[:question_id])
    # answer = question.find(params[:id])
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to question_path(params[:question_id]), notice: "Answer Deleted!"

  end

      private

      def answer_params
        params.require(:answer).permit([:body])
      end


      def find_answer
        @answer = Answer.find(params[:id])
      end

      def authorize_user
        unless (can? :manage, @answer) || (can? :destroy, @answer)
          redirect_to root_path, alert: "access denied"
        end
      end

end


# add_reference :questions, :category, index: true, foreign_key: true
