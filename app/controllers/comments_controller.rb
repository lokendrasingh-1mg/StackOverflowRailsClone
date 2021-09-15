class CommentsController < ApplicationController
  def index
    render json: commentable_type
  end

  def new
  end

  def create
    @user = User.find(params[:user_id])
    @comment = commentable_type.create!(**comment_params, user: @user)
    render json: @comment
  end

  def show
    @comment = commentable_type.find_by(id: params[:id])
    render json: @comment
  end

  def edit
  end

  def update
    @comment = commentable_type.find_by(id: params[:id])
    @comment&.update!(comment_params)
    render json: @comment
  end

  def destroy
    # TODO: behavior if entity doesn't exist
    @comment = commentable_type.find_by(id: params[:id])
    @comment&.destroy
    render json: @comment
  end

  private

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
