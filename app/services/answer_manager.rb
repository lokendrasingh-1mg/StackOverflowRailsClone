class AnswerManager
  def initialize(answer, user)
    self.answer = answer
    self.user = user
  end

  # Create/ update vote & update the total vote count using sidekiq
  def update_vote!(vote_type)
    answer_vote = Vote::AnswerVote.new(answer, user: user)
    answer_vote.vote_update(vote_type)
    VoteUpdateWorker.perform_async(answer.id, 'Answer')
  end

  private

  attr_accessor :answer, :user
end
