class CommentsController < ApplicationController

  # Use this model to help validate the current user
  # include SessionHelper

  # Add a comment, there is no individual page for this action, instead this is a partial page used in location's show page.
  # A user need to login to add a comment
  def create
    
    # Check if the current user is login or not
    # unless loggin_in?
    #   store_location
    #   flash[:danger] = "Please login in"
    #   redirect_to login_url
    #   return
    # end
    
    # Check if the location exist or not
    location = Location.find(params[:id])
    if location.nil?
      flash[:danger] = "The location does not exist"
      redirect_to "locations#index"
      return
    end

    # Create the comment
    user = current_user
    comment = Comment.new(comment_params)
    # Save the comment
    location.comments << comment
    user.comments << comment

    respond_to do |format|
      if comment.save
        format.js {}
        format.json { render :json => comment }
      else
        fromat.json { render :json => { error: "Falied to add the comment" } }
      end
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


private

  def comment_params
    params.require(:comment).permit(:content, :rate)
  end

end
