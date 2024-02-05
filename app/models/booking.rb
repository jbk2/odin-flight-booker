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
  has_and_belongs_to_many :passengers
  belongs_to :booking_owner, class_name: 'Passenger', foreign_key: 'booking_owner_id', optional: true
  validates :booking_owner_id, presence: true, on: :update

end
