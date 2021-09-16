class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :content, :votes, :user_id

  belongs_to :question
end
