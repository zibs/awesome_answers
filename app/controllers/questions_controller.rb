class QuestionsController < ApplicationController

  def index
    @questions = Question.recent(10)
  end

  def new
    @question = Question.new
  end

  def create
    #params =>  {"question"=>{"title"=>"Hello World", "body"=>"this is a test"}}
    # question = Question.new([:params])
    # using params.require ensures there is a key called `question` in my params. the `permit` method will only allow parameters that are explicitly listed. In this case, title and body.
    question_params = params.require(:question).permit([:title, :body])
    @question = Question.new(question_params)
    if @question.save
      # redirect_to question_path({id: @question.id})
      # redirect_to question_path({id: @question})
      # redirect_to question_path(@question)
      flash[:success] = "that's a really thoughtful question, thanks"
      redirect_to @question
    else
        # matches the template (not the action) specified
        # or can specify full path "questions/new" etc.
      render :new # will go to default behaviour if not specified
    end
    # redirect issues another HTTP `GET` request - render remains in cycle
    # will work through mass assignment
    # question = Question.new
    # question.title = params[:question][:title]
    # question.body = params[:question][:body]
    # question.save
  end
  # GET: /questions/13
  def show
    # find throws an exception when its not found.
    @question = Question.find(params[:id])
    @question.view_count += 1
    @question.save
  end

  def edit
    # finds question to be edited
    @question = Question.find(params[:id])
  end

  def update
    # fetch question first to update it#update with sanitized#strong params to update title/body#redirect to question show page
    @question = Question.find(params[:id])
    question_params = params.require(:question).permit([:title, :body])
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to root_path
  end

end
