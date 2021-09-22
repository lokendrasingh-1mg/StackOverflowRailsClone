class CommentVoteController < ApplicationController
  include Votable

  private

  def manager
    @manager ||= CommentManager.new(resource, user)
  end

  def klass
    Comment
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  def id
    @id ||= params[:id]
  end

  def valid_votes
    param! :id, Integer, required: true
  end
end
