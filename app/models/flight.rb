# == Schema Information
#
# Table name: flights
#
#  id                   :bigint           not null, primary key
#  arrival_time         :datetime
#  departure_time       :datetime
#  flight_duration_secs :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  arrival_airport_id   :bigint           not null
#  departure_airport_id :bigint           not null
#
# Indexes
#
#  index_flights_on_arrival_airport_id    (arrival_airport_id)
#  index_flights_on_departure_airport_id  (departure_airport_id)
#
# Foreign Keys
#
#  fk_rails_...  (arrival_airport_id => airports.id)
#  fk_rails_...  (departure_airport_id => airports.id)
#
class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: 'Airport'
  belongs_to :arrival_airport, class_name: 'Airport'
  has_many :bookings
  before_validation :set_flight_duration, on: :create
  validates :departure_airport_id, :arrival_airport_id, :departure_time, :arrival_time, presence: true

  delegate :country, :code, :city, :name, to: :departure_airport, prefix: true
  delegate :country, :code, :city, :name, to: :arrival_airport, prefix: true

  def set_flight_duration
    if departure_time.present? && arrival_time.present?
      self.flight_duration_secs = (arrival_time - departure_time).to_i
    end
  end
end
