class UserVote < ApplicationRecord
  enum vote_type: {
    down_vote: -1,
    up_vote: 1,
  }

  belongs_to :user
  belongs_to :votable, polymorphic: true
end
