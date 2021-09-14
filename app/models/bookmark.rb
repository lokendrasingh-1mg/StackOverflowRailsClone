class Bookmark < ApplicationRecord
  belongs_to :question
  belongs_to :user
end
