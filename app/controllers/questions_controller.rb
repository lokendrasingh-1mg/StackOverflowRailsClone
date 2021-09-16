class QuestionsController < ApplicationController
  before_action :populate_user, only: %i[create update destroy]
  before_action :populate_question, only: %i[show update destroy]
  before_action :authenticate_user, only: %i[update destroy]

  def index
    @questions = Question.includes(:answers)

    render json: @questions
  end

  def new
  end

  def create
    @question = @user.questions.create!(create_params)

    render json: @question
  end

  def show
    render json: @question
  end

  def edit
  end

  # TODO: enforce user authorization
  def update
    @question.update!(create_params)

    render json: @question
  end

  # TODO: mark user as anonymous instead of deleting it
  # Maybe update the user to -1: anonymous user
  # or use paranoid to retrieve all questions
  def destroy
    @question.destroy

    render json: { message: 'Delete Successful' }
  end

  private

  def create_params
    param! :heading, String, required: true, message: 'Question heading not specified'
    param! :description, String, required: true, message: 'Question description not specified'
    param! :user_id, Integer, required: true
    params.permit(:heading, :description)
  end

  def populate_user
    param! :user_id, Integer, required: true
    @user = User.find(params[:user_id])
  end

  def populate_question
    param! :id, Integer, required: true
    @question = Question.find(params[:id])
  end

  def authenticate_user
    redirect_to root_path unless @question.user_id == @user.id
  end
end
