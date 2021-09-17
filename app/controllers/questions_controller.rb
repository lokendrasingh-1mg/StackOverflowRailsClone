class QuestionsController < ApplicationController
  include ActionValidator
  include GenericCrud


  private

  def options
    @options ||= { user: user }
  end

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
