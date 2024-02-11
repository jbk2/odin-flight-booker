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
      flight = Flight.new(valid_attributes.except(attribute))
      expect(flight).to be_invalid
      expect(flight.errors[attribute]).to include("can't be blank")
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
      expect(flight.bookings).to be_truthy #i.e. for the association method to be defined
      expect(flight.bookings).to be_empty
    end
  end

end
