class Api::V1::QuestionsController < Api::BaseController
  # params[api_key]
  # http://localhost:3001/api/v1/questions?api_key=d1fafe23d67a1c230e5860fe98e138245c465e1d2982d545475c5027267a3e5f is now accessible

  def index
    @questions = Question.order("created_at DESC").limit(10)
    render json: @questions
  end

  def show
    @question  = Question.find(params[:id])
    render json: @question
  end

  def create
    # still captures parameters a la Rails.
    question_params = params.require(:question).permit(:title, :body)
    # doesn't need to be an instance variable anymore.
    question  = Question.new(question_params)
    question.user = @user
    if question.save
      head :ok
    else
      render json: { errors: question.errors.full_messages}
    end
  end


end
