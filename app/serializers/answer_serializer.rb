class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :content, :votes, :user_id, :question_id
end
