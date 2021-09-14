class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    render json: @questions
  end

  def new
  end

  def create
    # TODO: how to use rail_params
    param_validation
    @user = User.find(params[:user_id])
    @question = @user.questions.create!(question_params)
    render json: @question
  end

  def show
    @question = Question.find(params[:id])
    render json: @question
  end

  def edit

  end

  def update
    param_validation
    # TODO: enforce user authorization
    @question = Question.find(params[:id])
    @question.update!(question_params)
    render json: @question
  end

  def destroy
    @question = Question.find_by(id: params[:id])
    # TODO: mark user as anonymous instead of deleting it
    # Maybe update the user to -1: anonymous user
    # or use paranoid to retrieve all questions
    @question&.destroy
  end

  private

  def question_params
    params.require(:heading)
    params.require(:description)
    params.permit(:heading, :description)
  end

  def param_validation
    param! :heading, String, required: true, message: 'Question heading not specified'
    param! :description, String, required: true, message: 'Question description not specified'
    param! :user_id, Integer, required: true
  end

end
