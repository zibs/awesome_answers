class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question

    # @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to question_path(@question), notice: "Answer created!"
    else
      # rendering into another controller, hardcode
      render "questions/show"
    end
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
end


# add_reference :questions, :category, index: true, foreign_key: true
