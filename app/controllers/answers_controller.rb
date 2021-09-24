class AnswersController < CrudController
  include Votable

  before_action :validate_actions, only: %i[votes]

  private

  def manager
    @manager ||= AnswerManager.new(resource, user)
  end

  def klass
    @klass ||= Answer
  end

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
  def validate_create
    param! :question_id, Integer, required: true
    param! :user_id, Integer, required: true
    param! :content, String, required: true, message: 'Answer content not specified'
  end

  def validate_show
    param! :id, Integer, required: true
  end

  def validate_update
    param! :question_id, Integer, required: true
    param! :id, Integer, required: true
    param! :user_id, Integer, required: true
  end

  def validate_destroy
    param! :question_id, Integer, required: true
    param! :id, Integer, required: true
    param! :user_id, Integer, required: true
  end
end
