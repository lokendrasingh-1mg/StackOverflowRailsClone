class AnswersController < ApplicationController
  def index
    @question = Question.find(params[:question_id])
    @answers = @question.answers
    render json: @answers
  end

  def new
  end

  def create
    param_validation
    @user = User.find(params[:user_id])
    @question = Question.find(params[:question_id])
    @answer = Answer.create!(**answer_params, user: @user, question: @question)
    @question.answers << @answer
    render json: @answer
  end

  def show
    @question = Question.find(params[:question_id])
    @answers = @question.answers
    @answer = @answers[answer_id]
    render json: @answer
  end

  def edit
  end

  def update
    param_validation
    @question = Question.find(params[:question_id])
    @answers = @question.answers
    @answer = @answers[answer_id]
    @answer.update!(**answer_params)
    render json: @answer
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answers = @question.answers
    @answer = @answers[answer_id]
    @answer&.destroy
    render json: @answer
  end

  private

  # Convert answer_id to base 0 for array index usage
  # questions/:question_id/answers/1 should refer to 1st answer
  # for given question, not 1st answer in answers table
  def answer_id
    params[:id].to_i - 1
  end

  def answer_params
    params.require(:content)
    params.permit(:content)
  end

  def param_validation
    param! :content, String, required: true, message: 'Answer content not specified'
    param! :user_id, Integer, required: true
  end
end
