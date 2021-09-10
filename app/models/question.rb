class Question < ApplicationRecord
  belongs_to :user

  has_many :answers
  has_many :comments, as: :commentable
  has_many :uservotes, as: :votable
end
