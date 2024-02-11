require 'rails_helper'

RSpec.describe Flight, type: :model do
  let(:airport_1) { Airport.create(name: 'Parisian Airport', code:'0001', country_id: '01', country: 'France', city: 'Paris') }
  let(:airport_2) { Airport.create(name: 'Spanish Airport', code:'0002', country_id: '02', country: 'Spain', city: 'Madrid') }
  let(:flight) { Flight.create(departure_airport: airport_1, arrival_airport: airport_2, departure_time: Time.now + 1.hour , arrival_time: Time.now + 3.hours) }

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

    [:departure_airport_id, :arrival_airport_id, :departure_time, :arrival_time, :flight_duration_secs].each do |attribute|
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
