class QuestionsController < CrudController
  include Votable

  before_action :validate_actions, only: %i[index votes]

  def index
    @questions = Question.includes(:answers, :comments).page(page).per(limit)

    render json: @questions
  end

  private

  def manager
    @manager ||= QuestionManager.new(resource, user)
  end

  def klass
    @klass ||= Question
  end

  def validate_index
    param! :page, Integer, required: false, default: 0
    param! :limit, Integer, required: false, default: 10
  end

  def validate_create
    param! :heading, String, required: true, message: 'Question heading not specified'
    param! :description, String, required: true, message: 'Question description not specified'
    param! :user_id, Integer, required: true
  end

  def validate_show
    param! :id, Integer, required: true
  end

  def validate_update
    param! :id, Integer, required: true
    param! :heading, String, required: true, message: 'Question heading not specified'
    param! :description, String, required: true, message: 'Question description not specified'
    param! :user_id, Integer, required: true
  end

  def validate_destroy
    param! :id, Integer, required: true
    param! :user_id, Integer, required: true
  end

  def params_attributes
    params.permit(:heading, :description)
  end

  def page
    @page ||= params[:page]
  end

  def limit
    @limit ||= params[:limit]
  end
end
