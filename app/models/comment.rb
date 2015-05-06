class Comment < ActiveRecord::Base
  
  # Validation on the content and rate field
  validates :content, presence: true
  validates :rate, presence: true, numericality: true

  # The association with location and user
  belongs_to :user
  belongs_to :location
  # The association with vote
  has_many :votes
end
