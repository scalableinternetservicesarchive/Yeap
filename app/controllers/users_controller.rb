class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy ] 
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  hide_action(:logged_in_user, :correct_user, :admin_user)

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    
    # Select the user's activity, includes comments, vote and likes
    user_comments = Comment.includes(:location).where(:user_id => @user[:id]).order(:created_at => :desc).limit(20)
    user_likes = Like.includes(:location).where(:user_id => @user[:id]).order(:updated_at => :desc).limit(20)
    user_upvotes = Vote.includes(:comment).where(:user_id => @user[:id], :upvote => 1).order(:updated_at => :desc).limit(10)
    user_downvotes = Vote.includes(:comment).where(:user_id => @user[:id], :downvote => 1).order(:updated_at => :desc).limit(10)

    @user_activity = []
    user_comments.each { |elem| @user_activity << elem }
    user_likes.each { |elem| @user_activity << elem }
    user_upvotes.each { |elem| @user_activity << elem }
    user_downvotes.each { |elem| @user_activity << elem }

    @user_activity.sort_by! { |elem| elem[:updated_at] }
    @user_activity.reverse!

 end

  def create
    @user = User.new(user_params) 
    if @user.save
      @user.send_activation_email
      flash[:info] = 'Please check your email to active your account.'
      redirect_to root_url
=begin      
      log_in @user
      flash[:success] = 'Welcome to the sample App!'
      redirect_to @user
=end    
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else 
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = 'Please log in.'
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
