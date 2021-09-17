module GenericCrud
  extend ActiveSupport::Concern

  def index
    @entities = klass.includes(:answers, :comments).page(page).per(limit)

    render json: @entities
  end

  def create
    @entity = klass.new(**params_attributes, **options)
    @entity.save!

    render json: @entity
  end

  def show
    render json: send(resource)
  end

  # TODO: enforce user authorization
  def update
    redirect_to root_path unless valid_user?
    send(resource).update!(params_attributes)

    render json: send(resource)
  end

  # TODO: mark user as anonymous instead of deleting it
  # Maybe update the user to -1: anonymous user
  # or use paranoid to retrieve all questions
  def destroy
    redirect_to root_path unless valid_user?
    send(resource).destroy

    render json: { message: 'Delete Successful' }
  end

  # returns singularize resource name from url
  # /questions -> "question"
  # /questions/2 -> "question"
  # /questions?page=2&limit=10 -> "question"

  private

  def resource
    remove_query_params = request.url.split('?')[0]
    split_url = remove_query_params.split('/')
    resource_name = if split_url[-1].to_i.zero?
                      split_url[-1]
                    else
                      split_url[-2]
                    end

    @resource ||= resource_name.singularize
  end

  def klass
    @klass ||= resource.capitalize.constantize
  end
end
