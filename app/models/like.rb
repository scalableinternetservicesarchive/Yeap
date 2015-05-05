class Like < ActiveRecord::Base

  # Validate that the user and locaiotn exist
  validates_associated :user
  validates_associated :location

  belongs_to :user
  belongs_to :location
end
