class Bike < ApplicationRecord
  validates_presence_of    :identifier,
                           :current_station_id
  validates_uniqueness_of  :identifier, :theme_name
  
  belongs_to :current_station, class_name: :Station, primary_key: :identifier, foreign_key: :current_station_id, optional: true
  has_many :rental_history, class_name: :Rental, primary_key: :identifier, foreign_key: :bike_id 
  
  validates_numericality_of :identifier, :current_station_id
  
  validate :current_station_exists
  
  def current_station
    Station.find_by(identifier: current_station_id)
  end

  def identifier_with_name
    "#{identifier}: #{theme_name}"
  end

  private

  def current_station_exists
    return if Station.where(identifier: current_station_id).any?
    errors.add(:current_station_id, "Station Identifier must belong to an existing station.")
  end
end
