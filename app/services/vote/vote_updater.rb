module Vote
  class VoteUpdater < Base
    def initialize(obj, vote_type, user)
      super(obj, user: user)
      @vote_type = vote_type

    end

    def call
      votable_entity.vote_type = @vote_type
      votable_entity.save!
      votable_entity
    end
  end
end
