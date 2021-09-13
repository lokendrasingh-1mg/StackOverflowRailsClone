class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  has_many :comments, as: :commentable
  has_many :user_votes, as: :votable

  acts_as_paranoid
end
