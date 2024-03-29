# == Schema Information
#
# Table name: flights
#
#  id                   :bigint           not null, primary key
#  departure_airport_id :bigint           not null
#  arrival_airport_id   :bigint           not null
#  departure_time       :datetime
#  arrival_time         :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  flight_duration_secs :integer
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
