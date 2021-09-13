class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :uservotes, as: :votable

  acts_as_paranoid
end
