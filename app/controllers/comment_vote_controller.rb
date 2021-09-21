class CommentVoteController < ApplicationController
  include Votable

  private

  def klass
    Comment
  end

  def options
    @options ||= {
      user: user,
    }
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
