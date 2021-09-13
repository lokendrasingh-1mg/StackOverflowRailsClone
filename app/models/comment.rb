class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :user_votes, as: :votable

  acts_as_paranoid
end
