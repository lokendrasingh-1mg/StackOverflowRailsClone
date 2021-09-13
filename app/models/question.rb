class Question < ApplicationRecord
  belongs_to :user

  has_many :answers
  has_many :comments, as: :commentable
  has_many :uservotes, as: :votable
  has_many :bookmarks
  has_many :bookmark_users, through: :bookmarks, source: :user
  has_and_belongs_to_many :tags

  acts_as_paranoid
end
