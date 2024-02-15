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
    context 'without a flight_id' do
      let(:no_flight_booking) { build(:booking, flight: nil) }
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

  describe 'associations' do
    it 'belongs to a flight' do
      expect(booking.flight).to eq(flight)
    end

    context 'without any passenger before update' do
      let(:no_passenger_booking) { flight.bookings.build(flight_id: flight.id) }
      it 'is valid' do
        expect(no_passenger_booking).to be_valid
      end
    end

    context 'without any passenger after update' do
      let(:no_passenger_booking) { flight.bookings.build(flight_id: flight.id) }
      it 'is invalid' do
        no_passenger_booking.update(booking_owner_id: passenger_2.id)
        expect(no_passenger_booking).to be_invalid
      end
    end

    context 'with 1 passenger after update' do
      let(:one_passenger_booking) {
        booking = flight.bookings.build(booking_owner: booking_owner)
        booking.passengers << booking_owner
        booking.save
        booking
      }
      it 'is valid' do
        expect(one_passenger_booking).to be_valid
      end
    end

    it 'belongs to a booking_owner' do
      expect(booking.booking_owner).to eq(booking_owner)
    end
  end
  
end
