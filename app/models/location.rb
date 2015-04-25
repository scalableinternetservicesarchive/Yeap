class Location < ActiveRecord::Base

  # Validation each field of the Location
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :avg_price, numericality: true, allow_blank: true
  validates :start_time, timeliness: { type: :time }, allow_blank: true
  validates :end_time, timeliness: { type: :time }, allow_blank: true
  validates :latitude, numericality: true, allow_blank: true
  validates :longitude, numericality: true, allow_blank: true

  # The relationship with comments, a location could have many comments
  has_many :comments
end
