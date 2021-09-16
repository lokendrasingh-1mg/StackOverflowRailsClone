class CommentsController < ApplicationController
  before_action :populate_commentable_type, only: %i[index create show update destroy]
  before_action :populate_commentable_id, only: %i[create show update destroy]
  before_action :populate_user, only: %i[create update destroy]

  def index
    @comment = Comment.where(commentable_type: @commentable_type)

    render json: @comment
  end

  def new
  end

  def create
    klass = @commentable_type.constantize
    @comment = klass.find(@commentable_id).comments.create!(**comment_params, user: @user)

    render json: @comment
  end

  def show
    @comment = Comment.where(commentable_type: @commentable_type, commentable_id: @commentable_id)

    render json: @comment
  end

  def edit
  end

  def update
    klass = @commentable_type.constantize
    @comment = klass.find(@commentable_id).comments.find(params[:id])
    @comment.update!(comment_params)

    render json: @comment
  end

  def destroy
    # TODO: behavior if entity doesn't exist
    klass = @commentable_type.constantize
    @comment = klass.find(@commentable_id).comments.find(params[:id])
    @comment.destroy

    render json: @comment
  end

  private

  def populate_commentable_type
    param! :commentable_type, String, required: true, in: ["Question", "Answer"]
    @commentable_type = params[:commentable_type]
  end

  def populate_commentable_id
    param! :commentable_id, Integer, required: true
    @commentable_id = params[:commentable_id]
    @commentable_type = params[:commentable_type]
  end

  def populate_user
    param! :user_id, Integer, required: true
    @user = User.find(params[:user_id])
  end

  # Returns [Question/Answer]Comment depending upon url params
  def commentable_type
    # TODO: instance variable vs normal variable
    if params[:answer_id]
      @answer = Answer.find(params[:answer_id])
      @comments = @answer.comments
    else
      @question = Question.find(params[:question_id])
      @comments = @question.comments
    end
  end

  def comment_params
    params.require(:content)
    params.permit(:content)
  end
end
