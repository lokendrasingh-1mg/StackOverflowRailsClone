class AnswersController < ApplicationController
  include Votes

  private

  def klass
    @klass ||= Answer
  end

  # TODO: instead of overriding how to use Generic Options
  def options
    @options ||= { user: user, question: question }
  end

  def params_attributes
    params.permit(:content)
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  # TODO: generic crud validator?
  # similar to 4 args default constructor
  # which is called from: no arg, 1 arg, 2 arg, 3 arg
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
end
