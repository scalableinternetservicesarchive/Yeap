class CommentsController < ApplicationController

  # Use this model to help validate the current user
  include SessionsHelper

  # Add a comment, there is no individual page for this action, instead this is a partial page used in location's show page.
  # A user need to login to add a comment
  def create
    
    # Check if the current user is login or not
    check_login

    # Check if the location exist or not
    location = Location.find(params[:id])
    if location.nil?
      flash[:danger] = "The location does not exist"
      redirect_to_page locations_page
      return
    end

    user = current_user
    if user.nil?
      redirect_to_path login_path
      return
    end

    # Create the comment
    @comment = Comment.new(comment_params)
    # Save the comment
    location.comments << @comment
    user.comments << @comment

    # If successfully saved, respond with the javascript to prepend the new comment into the comment list
    if @comment.save
      respond_to do |format|
        format.js {}
      end
      return
    # If failed to save, redirect to the location show page
    else 
      flash[:danger] = "Failed to save the comment"
      redirect_to_page locations_page(location)
      return
    end

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

  def new

    # Check if the user is login
    check_login

    # Check the location exist
    @location = Location.find(params[:id])
    
    if @location.nil?
      flash[:danger] = "The location does not exist"
      redirect_to "locations#index"
      return
    end
    
    @comment = Comment.new

    # Respond with the javascript code to load the form
    respond_to do |format|
      format.js {}
    end
  end
  
  # Use this action to upvote a specific comment
  # This action has no render page, instead it has only a javascript to return to show the change of the upvote
  # POST /comments/:id/upvote
  def upvote
    # The user need to login first
    check_login
    # Check if the specific comment exist 
    @comment = Comment.find(params[:id])
    if @comment.nil?
      flash[:danger] = "The comment does not exist"
      redirect_to_path locations_path
    end
    
    # Update the specific record by increase the upvote field by 1
    @comment[:upvote] = @comment[:upvote] + 1
    if @comment.save
      respond_to do |format|
        format.js {}
      end
      return
    else
      flash[:danger] = "Upvote failed"
      redirect_to "locations#index"
      return
    end
  end

  # Use this action to downvote a specific comment
  # This action has no render page, instead it has only a javascript to return to show the change of the downvote
  # POST /comments/:id/downvote
  def downvote 
    # The user need to login first
    check_login
    # Check if the specific comment exist
    @comment = Comment.find(params[:id])
    if @comment.nil?
      flash[:danger] = "The comment does not exist"
      redirect_to_path locations_path
    end

    # Update the specific record by descrease the downvote field by 1
    @comment[:downvote] = @comment[:downvote] + 1
    if @comment.save
      respond_to do |format|
        format.js {}
      end
      return
    else
      flash[:danger] = "Upvote failed"
      redirect_to_path locations_path
      return
    end
  end
private

  def comment_params
    params.require(:comment).permit(:content, :rate)
  end
  
  # The helper function to help check login, if not login, redirect to login page
  def check_login
    unless logged_in?
      #  store_location
      flash[:danger] = "Please Login"
      redirect_to_page login_path
      return
    end
  end

  def redirect_to_page(page_path)
    render js: "window.location='#{page_path}'"
    return
  end
end
