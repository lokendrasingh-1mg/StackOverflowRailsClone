class Answer < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  validates :content, presence: true, length: { minimum: 10, maximum: 30_000 }

  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable
  has_many :user_votes, as: :votable
end
