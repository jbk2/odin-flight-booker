# == Schema Information
#
# Table name: bookings
#
#  id               :bigint           not null, primary key
#  flight_id        :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  booking_owner_id :bigint
#
class Booking < ApplicationRecord
  attr_accessor :passenger_count

  belongs_to :flight
  has_many :passengers
  accepts_nested_attributes_for :passengers, allow_destroy: true
  belongs_to :booking_owner, class_name: 'Passenger', foreign_key: 'booking_owner_id', optional: true
  validates :booking_owner_id, presence: true, on: :update

  # after_create :set_booking_owner

  # def set_booking_owner(current_passenger_id = nil)
  #   puts "******* Setting booking owner"
  #   owner_id = current_passenger_id || passengers.first.id
  #   self.update(booking_owner_id: owner_id)
  # end
end
