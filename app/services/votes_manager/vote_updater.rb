module VotesManager
  class VoteUpdater < ApplicationService
    def initialize(resource, vote_type, user)
      self.resource = resource
      self.vote_type = vote_type
      self.user = user
    end

    def call
      vote = resource.user_votes.find_or_initialize_by(user: user)
      vote.vote_type = vote_type
      vote.save!
      vote
    end

    private

    attr_accessor :resource, :vote_type, :user
  end
end
