class QuestionsController < ApplicationController
  # runs in the order defined
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  #we can specify :only or :except to be more specific about the actions which the before_action applies to
  def index
    @questions = Question.recent(10).page(params[:page]).per(10)
    respond_to do |format|
      format.html  { render }
      format.json { render json: @questions.select(:id, :title, :view_count) }
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question  = Question.new(question_params)
    # we don't have access to the @current_user, but we access it through the method
    @question.user = current_user
    if @question.save
      # should be in background job, should be in a begin end block.
      if @question.tweet_it
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
          config.consumer_secret     = ENV["TWITTER_SECRET_KEY"]
          config.access_token        = current_user.twitter_token
          config.access_token_secret = current_user.twitter_secret
        end
        client.update("New Question: #{@question.title}")
      end
      # redirect_to question_path({id: @question.id})
      # redirect_to question_path({id: @question})
      # redirect_to question_path(@question)
      flash[:success] = "That's a really thoughtful question -- thanks"
      redirect_to @question
    else
        # matches the template (not the action) specified
        # or can specify full path "questions/new" etc.
       flash[:danger] = "Question not created -- Check errors below"
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
    # @question = Question.find(params[:id])
    # @question.view_count += 1
    @question.save
    @answer = Answer.new
    @answers = @question.answers
    respond_to do |format|
      format.html { render}
      format.json { render json: @question.to_json(include: :answers) }
    end

  end

  def edit
    # finds question to be edited
    # @question = Question.find(params[:id])
  end

  def update
    # fetch question first to update it#update with sanitized#strong params to update title/body#redirect to question show page
    # @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to(question_path(@question), { notice: "Question updated" })
    else
      render :edit
    end
  end

  def destroy
    # question = Question.find(params[:id])
    @question.destroy
    redirect_to root_path, flash: { danger: "Question Deleted" }
  end

      private

      def question_params
        params.require(:question).permit([:title, :body,
              :category_id, { tag_ids: [] }, :tweet_it ])
      end
            #params =>  {"question"=>{"title"=>"Hello World", "body"=>"this is a test"}}
            # question = Question.new([:params])
            # using params.require ensures there is a key called `question` in my params. the `permit` method will only allow parameters that are explicitly listed. In this case, title and body.
            # local methods and variables are the same

      def find_question
        @question = Question.find(params[:id])
      end

      def authorize_user
        # use cancancan to check
        unless can? :manage, @question
        # if @question.user != current_user
          redirect_to root_path , alert: "Access Denied"
        end
      end




      #####MOVED TO APPLICATION CONTROLLER!
      # # exception for DoubleRenderError in the callbacks
      # def authenticate_user
      #   # unless session[:user_id]
      #   unless user_signed_in?
      #     redirect_to new_session_path
      #   end
      # end

end
