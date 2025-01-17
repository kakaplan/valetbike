class Station < ApplicationRecord
  enum status: [ :closed, :open ]
  validates_presence_of    :identifier,
                           :name,
                           :address,
                           :status,
                           :longitude,
                           :latitude
  validates_uniqueness_of  :identifier
  validates_numericality_of :identifier, :longitude, :latitude
  
  has_many :docked_bikes, class_name: :Bike, primary_key: :identifier, foreign_key: :current_station_id
  has_many :rental_start_history, class_name: :Rental, primary_key: :identifier, foreign_key: :start_station_id 
  has_many :rental_end_history, class_name: :Rental, primary_key: :identifier, foreign_key: :end_station_id 

  def identifier_with_name
    "#{identifier}: #{name}"
  end
end
