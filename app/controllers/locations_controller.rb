class LocationsController < ApplicationController
  
  before_action :set_location, only: [:show]

  # Return a list of locations to display on the homepage.
  # Currently, only return a list of random locations. In the future version, return the locations baed on the user's location.
  # The user does not need to login to obtain the list of locations.
  # The result should be cached in order to improve the performance.
  def index
    
    # Check if there is parameter num_to_return, otherwise set to the default number
    num_to_return = params[:num_to_return].nil ? 50 : params[:num_to_return]
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

  private
  def set_location
    @location = Location.find(params[:id])
  end
end
