class VoteUpdateWorker
  include Sidekiq::Worker

  def perform(obj_id, klass)
    obj = klass.constantize.find(obj_id)
    klass = "Vote::#{klass}Vote".constantize
    klas_vote_obj = klass.new(obj)
    klas_vote_obj.total_vote_count
    puts 'Update completed'
  end
end
