class TaskVoteCountUpdaterJob < ApplicationJob
  queue_as :default

  def perform(obj)
    obj.total_vote_count
    puts 'Update completed'
  end
end
