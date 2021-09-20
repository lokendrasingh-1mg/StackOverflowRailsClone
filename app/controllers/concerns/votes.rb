module Votes
  extend ActiveSupport::Concern

  def votes
    render json: VotesManager::VoteUpdater.call(resource, vote_type, user)
  end

  private

  def vote_type
    @vote_type ||= params[:vote_type]
  end

  def valid_votes
    param! :user_id, Integer, required: true
    param! :vote_type, Integer, required: true, in: [1, -1]
  end
end
