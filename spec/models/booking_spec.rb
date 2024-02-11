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
require 'rails_helper'

RSpec.describe Booking, type: :model do
  include_context 'common setup'

  describe 'validations' do
    let(:booking) { Booking.new(flight_id: flight.id) }

    context 'without a flight_id' do
      let(:no_flight_booking) { Booking.new(flight_id: nil) }
      it 'is invalid' do
        expect(no_flight_booking).to be_invalid
      end
    end

    context 'with a flight_id' do
      it 'is valid' do
        expect(booking).to be_valid
      end
    end
    
    context 'without a booking_owner on update' do
      it 'is invalid' do
        booking.booking_owner_id = nil
        booking.save
        expect(booking).to be_invalid
      end
    end
    
    context 'with a booking_owner on update' do
      it 'is valid' do
        booking.booking_owner_id = booking_owner.id
        booking.save
        expect(booking).to be_valid
      end
    end
  end

  
end
