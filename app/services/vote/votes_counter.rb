module Vote
  class VotesCounter < Base
    def call
      obj.votes = total_up_vote - total_down_vote
      obj.save!
      obj
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
