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
require 'rails_helper'

RSpec.describe Flight, type: :model do
  include_context 'common setup'
  
  RSpec.shared_examples 'a flight with mandatory attributes' do |attribute|
    it "is invalid without a #{attribute}" do
      flight_attributes = valid_attributes.merge(attribute => nil)
      flight = build(:flight_1, flight_attributes)
      expect(flight).to be_invalid
      expect(flight.errors[attribute]).to include("can't be blank"), "Expected errors to include \"can't be blank\" for #{attribute}, but got #{flight.errors.full_messages.to_sentence}"
      puts flight.errors.full_messages.to_sentence
    end
  end

  describe 'validations' do
    let(:valid_attributes) {
      { departure_airport_id: airport_1.id, arrival_airport_id: airport_2.id,   departure_time: Time.now + 1.hour , arrival_time: Time.now + 3.hours }
    }

    [:departure_airport_id, :arrival_airport_id, :departure_time, :arrival_time].each do |attribute|
      include_examples 'a flight with mandatory attributes', attribute
    end
  end

  describe 'associations' do
    it 'belongs to a departure airport' do
      expect(flight.departure_airport).to eq(airport_1)
    end

    it 'belongs to an arrival airport' do
      expect(flight.arrival_airport).to eq(airport_2)
    end

    it 'has many bookings' do
      expect(flight.bookings).to be_truthy #i.e. for the #bookings association method to be defined
      expect(flight.bookings).to include(booking_1)
    end
  end

end
