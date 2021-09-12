class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :questions
  has_many :answers
  has_many :bookmarks
  has_many :bookmark_questions, through: :bookmarks, source: :question
  has_and_belongs_to_many :tags

end
