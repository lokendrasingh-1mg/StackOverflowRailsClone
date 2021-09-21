class TaskVoteCountUpdaterJob < ApplicationJob
  queue_as :default

  def perform(obj)
    Vote::VotesCounter.call(obj)
    p 'Update completed'
  end
end
