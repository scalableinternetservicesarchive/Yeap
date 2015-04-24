class CommentsController < ApplicationController

  # a log-ined user add a comment
  def add_comment
    params[:user_id, :location_id, :content]
  end

  # a log-ined user changes his comment
  def edit_comment
    params[:user_id] # or session
    # Q: does user's comment on a place unique?
  end

  # a log-ined user deletes his comment
  def delete_comment
    params[:user_id] # or session
  end

  # get user(#user_id)'s comment on place(#location_id)
  def get_comment
    params[:user_id, :location_id]

  end

  # a log-ined user votes on a place
  def change_vote
    params[:user_id, :location_id, :vote]
    # Q: merge 'upvote' and 'downvote' as 'vote' with 2 values?

  end  

  # get the user's vote on the place
  def get_vote
    params[:user_id, :location_id]
  end

end
