module GenericCrud
  extend ActiveSupport::Concern

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

  # TODO: enforce user authorization
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

  def options
    @options ||= { user: user }
  end

  # TODO: create a generic getter from params
  # :user_id, :question_id
  def user
    @user ||= User.find(params[:user_id])
  end

  def valid_user?
    resource.user_id == user.id
  end

  # returns singularize resource name from url
  # /questions -> "question"
  # /questions/2 -> "question"
  # /questions?page=2&limit=10 -> "question"
  def resource_name
    remove_query_params = request.url.split('?')[0]
    split_url = remove_query_params.split('/')
    name = if split_url[-1].to_i.zero?
             split_url[-1]
           else
             split_url[-2]
           end

    @resource_name ||= name.singularize
  end

  def klass
    @klass ||= resource_name.capitalize.constantize
  end

  def resource
    @resource ||= klass.find(params[:id])
  end
end
