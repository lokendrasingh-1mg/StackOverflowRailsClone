module VotesManager
  # Returns sum of votes for provided resource
  class VotesCounter < ApplicationService
    def initialize(resource)
      self.resource = resource
    end

    def call
      # TODO: Is this a memory concern?
      resource.votes = resource.user_votes.where(vote_type: :up_vote).count - resource.user_votes.where(vote_type: :down_vote).count
      resource.save!
      resource
    end

    private

    attr_accessor :resource
  end
end
