module Votes
  extend ActiveSupport::Concern

  def votes
    vote = resource.user_votes.find_by(user: user)
    if vote
      vote.vote_type = vote_type
      vote.save!
      render json: vote
    else
      render json: resource.user_votes.create!(
        vote_type: vote_type,
        user: user,
      )
    end
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
