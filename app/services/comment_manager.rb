class CommentManager
  include Vote

  def initialize(comment, user)
    self.comment = comment
    self.user = user
  end

  # Create/ update vote & update the total vote count using sidekiq
  def update_vote!(vote_type)
    comment_vote = CommentVote.new(comment, user: user)
    comment_vote.vote_update(vote_type)
  end

  private

  attr_accessor :comment, :user
end
