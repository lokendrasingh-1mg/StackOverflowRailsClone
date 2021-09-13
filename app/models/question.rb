class Question < ApplicationRecord
  acts_as_paranoid
  has_paper_trail

  validates :heading, presence: true, length: { minimum: 10, maximum: 500 }
  validates :description, presence: true, length: { minimum: 10, maximum: 30_000 }

  belongs_to :user

  has_many :answers
  has_many :comments, as: :commentable
  has_many :user_votes, as: :votable
  has_many :bookmarks
  has_many :bookmark_users, through: :bookmarks, source: :user
  has_and_belongs_to_many :tags
end
