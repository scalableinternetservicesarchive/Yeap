class Vote < ActiveRecord::Base

  # Validate the user and comment exist
  validates_associated :user
  validates_associated :comment

  belongs_to :user
  belongs_to :comment
  
end
