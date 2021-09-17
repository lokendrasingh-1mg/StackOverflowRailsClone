class AnswersController < ApplicationController
  include ActionValidator

  def create
    @answer = question.answers.create!(**params_attributes, user: user)

    render json: @answer
  end

  def show
    render json: answer
  end

  def update
    redirect_to root_path unless valid_user?
    answer.update!(params_attributes)

    render json: answer
  end

  def destroy
    redirect_to root_path unless valid_user?
    answer.destroy

    render json: { message: 'Delete Successful' }
  end

  private

  def params_attributes
    params.permit(:content)
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def answer
    @answer ||= Answer.find(params[:id])
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  def valid_create
    param! :question_id, Integer, required: true
    param! :user_id, Integer, required: true
    param! :content, String, required: true, message: 'Answer content not specified'
  end

  def valid_show
    param! :id, Integer, required: true
  end

  def valid_update
    param! :question_id, Integer, required: true
    param! :id, Integer, required: true
    param! :user_id, Integer, required: true
  end

  def valid_destroy
    param! :question_id, Integer, required: true
    param! :id, Integer, required: true
    param! :user_id, Integer, required: true
  end

  def valid_user?
    answer.user_id == user.id
  end
end
