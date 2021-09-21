module Vote
  class VotesCounter < Base
    def call
      votable_entity.votes = total_up_vote - total_down_vote
      votable_entity.save!
      votable_entity
    end

    private

    def total_up_vote
      obj.user_votes.where(vote_type: :up_vote).count
    end

    def total_down_vote
      obj.user_votes.where(vote_type: :down_vote).count
    end
  end
end
