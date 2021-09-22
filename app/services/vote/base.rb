module Vote
  class Base
    def initialize(obj, user: nil)
      self.obj = obj
      self.user = user
    end

    def vote_update(vote_type)
      votable_entity.vote_type = vote_type
      votable_entity.save!
      # TaskVoteCountUpdaterJob.set(wait: 1.second).perform_later(self)
      # TaskVoteCountUpdaterJob.perform_now(self)
      VoteUpdateWorker.perform_async(self)
      votable_entity
    end

    def total_vote_count
      obj.votes = total_up_vote - total_down_vote
      obj.save!
      obj
    end

    private

    attr_accessor :obj, :user

    def votable_entity
      @votable_entity ||= obj.user_votes.find_or_initialize_by(user: user)
    end

    def total_up_vote
      obj.user_votes.where(vote_type: :up_vote).count
    end

    def total_down_vote
      obj.user_votes.where(vote_type: :down_vote).count
    end
  end
end
