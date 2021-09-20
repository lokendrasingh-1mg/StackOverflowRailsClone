class ApplicationController < ActionController::Base
  before_action :validate_actions, only: %i[index create show update destroy votes]

  skip_before_action :verify_authenticity_token

  class UnauthorizedUser < StandardError
  end

  def create
    @entity = klass.new(**params_attributes, **options)
    @entity.save!

    render json: @entity
  end

  def show
    render json: resource
  end

  def update
    raise UnauthorizedUser unless valid_user?

    resource.update!(params_attributes)

    render json: resource
  end

  # TODO: mark user as anonymous instead of deleting it
  # Maybe update the user to -1: anonymous user
  # or use paranoid to retrieve all questions
  def destroy
    raise UnauthorizedUser unless valid_user?

    resource.destroy

    render json: { message: 'Delete Successful' }
  end

  private

  def validate_actions
    action = params[:action]
    send("valid_#{action}")
  end

  def options
    @options ||= { user: user }
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  def valid_user?
    resource.user_id == user.id
  end

  def resource
    @resource ||= klass.find(params[:id])
  end
end
