class AnswersController < ApplicationController
  before_action :find_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user #, except: [:index, :show]
  # don't need that since there are only these actions in the first place...
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)

    @answer.question = @question
    # current_user here requires the `if` statement in ApplicationController since it could raise an exception if there was no user?
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
    if @answer.update(answer_params)
      redirect_to question_path(@answer.question_id), notice: "Question Updated"
    else
      flash[:alert] = "Not updated.."
      render :edit
    end
  end

  def destroy
    # to ensure that both question and answer id matches
    # question = Question.find(params[:question_id])
    # answer = question.find(params[:id])
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to question_path(params[:question_id]), alert: "Answer Deleted!"

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
