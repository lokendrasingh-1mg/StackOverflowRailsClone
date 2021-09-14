class Comment < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :user_votes, as: :votable
end
