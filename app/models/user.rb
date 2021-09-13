class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :questions
  has_many :answers
  has_many :bookmarks
  has_many :bookmark_questions, through: :bookmarks, source: :question
  has_and_belongs_to_many :tags

end
