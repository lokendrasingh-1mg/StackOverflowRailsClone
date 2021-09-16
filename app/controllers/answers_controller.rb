class AnswersController < ApplicationController
  before_action :populate_question, only: %i[create update destroy]
  before_action :populate_answer, only: %i[show update destroy]
  before_action :populate_user, only: %i[create update destroy]
  before_action :authenticate_user, only: %i[update destroy]

  def new
  end

  def create
    @answer = @question.answers.create!(**create_params, user: @user)

    render json: @answer
  end

  def show
    render json: @answer
  end

  def edit
  end

  def update
    @answer.update!(create_params)

    render json: @answer
  end

  def destroy
    @answer.destroy

    render json: { message: 'Delete Successful' }
  end

  private

  def create_params
    param! :content, String, required: true, message: 'Answer content not specified'
    param! :user_id, Integer, required: true
    params.permit(:content)
  end

  def populate_question
    param! :question_id, Integer, required: true
    @question = Question.find(params[:question_id])
  end

  def populate_answer
    param! :id, Integer, required: true
    @answer = Answer.find(params[:id])
  end

  def populate_user
    param! :user_id, Integer, required: true
    @user = User.find(params[:user_id])
  end

  def authenticate_user
    redirect_to root_path unless @answer.user_id == @user.id
  end
end
