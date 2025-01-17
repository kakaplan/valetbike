class Rental < ApplicationRecord
    enum status: [ :closed, :open ]
    validates_presence_of  :start_time,
                           :start_station_id,
                           :bike_id,
                           :user_id,
                           :card_id

    belongs_to :bike_rented, class_name: :Bike, primary_key: :identifier, foreign_key: :bike_id
    belongs_to :user_rented, class_name: :User, primary_key: :id, foreign_key: :user_id
    belongs_to :card_rented, class_name: :Card, primary_key: :id, foreign_key: :card_id
    belongs_to :start_station, class_name: :Station, primary_key: :identifier, foreign_key: :start_station_id
    belongs_to :end_station, class_name: :Station, primary_key: :identifier, foreign_key: :end_station_id, optional: true

    def rental_length_in_seconds
        current_time = Time.now
        rental_len = current_time - start_time
        rental_len.to_i
    end

    def date_created
        datetime = created_at.in_time_zone("Eastern Time (US & Canada)")
        datetime.strftime("%B %d, %Y")
    end

    def start
        datetime = start_time.in_time_zone("Eastern Time (US & Canada)")
        datetime.strftime("%I:%M %p ET")
    end

    def end
        datetime = end_time.in_time_zone("Eastern Time (US & Canada)")
        datetime.strftime("%I:%M %p ET")
    end
end

