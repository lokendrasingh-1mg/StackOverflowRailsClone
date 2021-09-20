module VotesManager
  class VoteUpdater < ApplicationService
    def initialize(resource, vote_type, user)
      @resource = resource
      @vote_type = vote_type
      @user = user
    end

    def call
      vote = resource.user_votes.find_by(user: user)
      if vote
        vote.vote_type = vote_type
        vote.save!
        vote
      else
        resource.user_votes.create!(
          vote_type: vote_type,
          user: user,
        )
      end
    end

    private

    attr_reader :resource, :vote_type, :user
  end
end
