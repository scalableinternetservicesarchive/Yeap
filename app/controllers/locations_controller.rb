class LocationsController < ApplicationController
  
  before_action :set_location, only: [:show]

  include SessionsHelper
  # Return a list of locations to display on the homepage.
  # Currently, only return a list of random locations. In the future version, return the locations baed on the user's location.
  # The user does not need to login to obtain the list of locations.
  # The result should be cached in order to improve the performance.
  def index
    
    # Check if there is parameter num_to_return, otherwise set to the default number
    num_to_return = params[:num_to_return].nil? ? 50 : params[:num_to_return]
    @locations = Location.order("RAND()").limit(num_to_return)

  end

  # Return the detail information of a specific location.
  # There is no need to check the if the user is login or not. However, if the user trys to add a comment, then he must frst login.
  # The result should be cached.
  def show
    # If the location is not found, redirect to the index page
    if @location.nil?
      redirect_to action: :index
    end
  end

  # Like a specific location.
  # The user need to login first inorder to like
  # There is no html page for this action, only a DOM on location's show page would be effected
  # /locations/:id/like
  def like
  
    # The user need to login first
    unless logged_in?
      flash[:danger] = "Please Login"
      redirect_to_page login_path
      return
    end
    # Find the record
    user_id = session[:user_id]
    location_id = params[:id]
    
    # Check if the locaiton exist
    @location = Location.find(location_id)
    if @location.nil?
      redirect_to_path locations_path
    end

    record = Like.find_by(:user_id => user_id, :location_id => location_id)
    # If there is no record, then the user have not liked this location
    # Insert a new record into the like table
    if record.nil?
      new_record = Like.new
      new_record[:user_id] = user_id
      new_record[:location_id] = location_id
      
      if new_record.save
        @like = "Liked"
        respond_to do |format|
          format.js { }
        end
      else
        redirect_to_path action: :index
      end
    # Otherwise the user has already liked the location
    # Delete the location
    else
      if record.destroy
        @like = "Like"
        respond_to do |format|
          format.js {}
        end
      else
        redirect_to_path action: :index
      end
    end
      
  end

  private
  def set_location
    @location = Location.includes(:comments).find(params[:id])
    # Calculate the rate
    sum = 0.0
    count = 0
    @location.comments.each do |comment|
      sum += comment[:rate]
      count += 1
    end
    baserate = @location.rate.to_i
    @rate = (count == 0) ? baserate : ((sum * 0.5 + baserate * 0.5) / count)
    
    set_liked

    set_votes
  end

  # Set the like status between a specific user and a specific location
  # If the use is logged in, then directly check the information in the likes table
  # Otherwise, set the like status to not liked
  def set_liked

    @like = "Like"
    
    # Update the @like information here if the user has logged in
    if logged_in?
      user_id = session[:user_id]
      location_id = params[:id]
      record = Like.find_by(:user_id => user_id, :location_id => location_id)
      if !record.nil?
        @like = "Liked"
      end
    end
  end

  # Set the list of votes of the user
  # If the user is not login, then he has no upvote or downvote right now
  # This is used for location's show page to render the comments
  def set_votes
    
    @upvote = []
    @downvote = []

    if logged_in?
      votes = Vote.where(:user_id => session[:user_id]).to_a
      votes.each do |vote|
        @upvote << vote[:comment_id].to_i if vote[:upvote].to_i == 1
        @downvote << vote[:comment_id].to_i if vote[:downvote].to_i == 1
      end
    end
  end

  def check_login
    unless logged_in?
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
