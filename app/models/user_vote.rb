class UserVote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true
end
