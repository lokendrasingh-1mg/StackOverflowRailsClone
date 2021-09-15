class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :heading, :description, :votes, :user_id
end
