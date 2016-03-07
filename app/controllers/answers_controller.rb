class AnswersController < ApplicationController
  before_action :find_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index]
  # don't need that since there are only these actions in the first place...
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @question = Question.find(params[:question_id])
    render json: @question.answers
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    # current_user here requires the `if` statement in ApplicationController since it could raise an exception if there was no user?
    @answer.user = current_user
    # @answer = @question.answers.new(answer_params)
    # special rails method respond_to takes a variable called format and a corresponding block
    respond_to do |format|
      if @answer.save
        AnswersMailer.notify_question_owner(@answer).deliver_later
        # execute code as html, passing in block of code to be executed.
        format.html { redirect_to question_path((@question), flash: { success:  "Answer created!" }) }

        format.js { render :create_success }
      else
        # rendering into another controller, hardcode
        format.html { render "questions/show" }
        # respond to javascript, execute inner block as JS on client
        # format.js { render js: "alert('error happened');" }
        format.js { render :create_failure }
      end
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
    respond_to do |format|
      format.html { redirect_to question_path(params[:question_id]), flash: { danger: "Answer Deleted!" } }
      format.js { render }
      # this renders app/views/answers/destroy.js.erb}
    end
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
