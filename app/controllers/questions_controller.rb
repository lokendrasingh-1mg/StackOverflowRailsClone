class QuestionsController < ApplicationController
  include ActionValidator

  def index
    @questions = Question.includes(:answers, :comments).page(page).per(limit)

    render json: @questions
  end

  def create
    @question = user.questions.create!(params_attributes)

    render json: @question
  end

  def show
    render json: question
  end

  # TODO: enforce user authorization
  def update
    redirect_to root_path unless valid_user?
    question.update!(params_attributes)

    render json: question
  end

  # TODO: mark user as anonymous instead of deleting it
  # Maybe update the user to -1: anonymous user
  # or use paranoid to retrieve all questions
  def destroy
    redirect_to root_path unless valid_user?
    question.destroy

    render json: { message: 'Delete Successful' }
  end

  private

  def valid_index
    param! :page, Integer, required: false, default: 0
    param! :limit, Integer, required: false, default: 10
  end

  def valid_create
    param! :heading, String, required: true, message: 'Question heading not specified'
    param! :description, String, required: true, message: 'Question description not specified'
    param! :user_id, Integer, required: true
  end

  def valid_show
    param! :id, Integer, required: true
  end

  def valid_update
    param! :id, Integer, required: true
    param! :heading, String, required: true, message: 'Question heading not specified'
    param! :description, String, required: true, message: 'Question description not specified'
    param! :user_id, Integer, required: true
  end

  def valid_destroy
    param! :id, Integer, required: true
    param! :user_id, Integer, required: true
  end

  def params_attributes
    params.permit(:heading, :description)
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  def question
    @question ||= Question.find(params[:id])
  end

  def page
    @page ||= params[:page]
  end

  def limit
    @limit ||= params[:limit]
  end

  def valid_user?
    question.user_id == user.id
  end
end
