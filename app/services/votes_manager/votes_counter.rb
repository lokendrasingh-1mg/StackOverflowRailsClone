module VotesManager
  # Returns sum of votes for provided resource
  class VotesCounter < ApplicationService
    def initialize(resource)
      @resource = resource
    end

    def call
      # TODO: Is this a memory concern?
      resource.votes = resource.user_votes.map(&:vote_type).sum
      resource
    end

    private

    attr_reader :resource
  end
end
