class VoteUpdateWorker
  include Sidekiq::Worker

  def perform(obj)
    obj.total_vote_count
    puts 'Update completed'
  end
end
