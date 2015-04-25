class Comment < ActiveRecord::Base
  
  # Validation on the content and rate field
  validates :content, presence: true
  validates :rate, presence: true, numerically: true

  # The association with location and user
  belongs_to :user
  belongs_to :location
end
