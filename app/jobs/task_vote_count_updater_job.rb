class TaskVoteCountUpdaterJob < ApplicationJob
  queue_as :default

  def perform(obj_id, object_type)
    object_ = object_type.find(obj_id)
    "Vote::#{object_type.to_s}Vote".constantize.new(object_).total_vote_count
    obj.total_vote_count
    puts 'Update completed'
  end
end
