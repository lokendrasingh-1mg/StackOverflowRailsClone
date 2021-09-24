class CommentsController < CrudController
  before_action :index

  def index
    @comment = Comment.where(commentable_type: commentable_type)

    render json: @comment
  end

  def show
    @comment = Comment.where(commentable_type: commentable_type, commentable_id: commentable_id)

    render json: @comment
  end

  private

  def resource
    @resource ||= klass.find_by!(
      **options,
      id: id,
    )
  end

  def options
    @options ||= {
      commentable_type: commentable_type,
      commentable_id: commentable_id,
      user: user,
    }
  end

  def klass
    @klass ||= Comment
  end

  def commentable_type
    @commentable_type ||= params[:commentable_type]
  end

  def commentable_id
    @commentable_id ||= params[:commentable_id]
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  def id
    @id ||= params[:id]
  end

  def params_attributes
    params.permit(:content)
  end

  def validate_index
    param! :commentable_type, String, required: true, in: %w[Question Answer]
  end

  def validate_create
    param! :commentable_type, String, required: true, in: %w[Question Answer]
    param! :commentable_id, Integer, required: true
    param! :user_id, Integer, required: true
  end

  def validate_show
    param! :commentable_type, String, required: true, in: %w[Question Answer]
    param! :commentable_id, Integer, required: true
  end

  def validate_update
    param! :commentable_type, String, required: true, in: %w[Question Answer]
    param! :commentable_id, Integer, required: true
    param! :user_id, Integer, required: true
    param! :id, Integer, required: true
  end

  def validate_destroy
    param! :commentable_type, String, required: true, in: %w[Question Answer]
    param! :commentable_id, Integer, required: true
    param! :user_id, Integer, required: true
    param! :id, Integer, required: true
  end
end
