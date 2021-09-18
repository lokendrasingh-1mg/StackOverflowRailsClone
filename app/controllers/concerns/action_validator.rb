module ActionValidator
  extend ActiveSupport::Concern

  included do
    before_action :validate_actions, only: %i[index create show update destroy votes]
  end

  def validate_actions
    action = params[:action]
    send("valid_#{action}")
  end
end
