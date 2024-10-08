# == Schema Information
#
# Table name: bookings
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  booking_owner_id :bigint
#  flight_id        :bigint           not null
#
# Indexes
#
#  index_bookings_on_booking_owner_id  (booking_owner_id)
#  index_bookings_on_flight_id         (flight_id)
#
# Foreign Keys
#
#  fk_rails_...  (booking_owner_id => passengers.id)
#  fk_rails_...  (flight_id => flights.id)
#
class Booking < ApplicationRecord
  attr_accessor :passenger_count

  belongs_to :flight
  has_and_belongs_to_many :passengers
  belongs_to :booking_owner, class_name: 'Passenger', foreign_key: 'booking_owner_id', optional: true
  
  validates :booking_owner_id, presence: true, on: :update
  validate :must_have_at_least_one_passenger, on: :update

  private
  def must_have_at_least_one_passenger
    return if passengers.any?
    errors.add(:passengers, "must have at least one passenger")
  end
end
