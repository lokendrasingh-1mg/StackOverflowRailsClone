module Votable
  extend ActiveSupport::Concern

  def votes
    render json: manager.update_vote!(vote_type)
  end

  private

  def vote_type
    @vote_type ||= params[:vote_type]
  end

  def validate_votes
    param! :user_id, Integer, required: true
    param! :vote_type, String, required: true, in: %w[up_vote down_vote]
  end
end
